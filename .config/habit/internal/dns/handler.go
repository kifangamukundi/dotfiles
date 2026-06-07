package dns

import (
	"context"
	"crypto/tls"
	"fmt"
	"github.com/miekg/dns"
	"log"
	"sync"
	"time"
)

const (
	MaxCacheEntries = 2000
	DefaultTTL      = 300
	UpstreamTimeout = 2 * time.Second
)

type BlockChecker interface {
	IsWhitelisted(domain string) bool
	IsDiscoveryMode() bool
}

type cacheEntry struct {
	msg       *dns.Msg
	expiresAt time.Time
}

type Handler struct {
	Upstreams []string
	BlockMode string
	dotClient *dns.Client
	checker   BlockChecker
	cache     map[string]cacheEntry
	cacheKeys []string
	cacheMu   sync.RWMutex
}

func NewHandler(upstreams []string, blockMode string, checker BlockChecker) *Handler {
	return &Handler{
		Upstreams: upstreams,
		BlockMode: blockMode,
		dotClient: &dns.Client{
			Net: "tcp-tls",
			TLSConfig: &tls.Config{
				InsecureSkipVerify: false,
			},
			Timeout: UpstreamTimeout,
		},
		checker: checker,
		cache:   make(map[string]cacheEntry),
	}
}

func (h *Handler) ServeDNS(w dns.ResponseWriter, r *dns.Msg) {
	if len(r.Question) == 0 {
		return
	}

	for _, q := range r.Question {
		if h.checker != nil {
			whitelisted := h.checker.IsWhitelisted(q.Name)
			if !whitelisted && !h.checker.IsDiscoveryMode() {
				h.returnBlocked(w, r, q)
				return
			}
			if !whitelisted && h.checker.IsDiscoveryMode() {
				log.Printf("[DISCOVERY] Allowed non-whitelisted domain: %s", q.Name)
			}
		}
	}

	q := r.Question[0]
	cacheKey := fmt.Sprintf("%d:%s", q.Qtype, q.Name)

	if resp := h.getFromCache(cacheKey, r.Id); resp != nil {
		w.WriteMsg(resp)
		return
	}

	// Clean Parallel Resolution
	msg := h.resolveParallel(r)

	if msg != nil {
		h.addToCache(cacheKey, msg)
		w.WriteMsg(msg)
	}
}

func (h *Handler) returnBlocked(w dns.ResponseWriter, r *dns.Msg, q dns.Question) {
	log.Printf("Blocked non-whitelisted domain: %s", q.Name)
	msg := new(dns.Msg)
	msg.SetReply(r)
	if h.BlockMode == "nxdomain" {
		msg.SetRcode(r, dns.RcodeNameError)
	} else {
		if q.Qtype == dns.TypeA {
			rr, _ := dns.NewRR(fmt.Sprintf("%s 60 IN A 0.0.0.0", q.Name))
			msg.Answer = append(msg.Answer, rr)
		} else if q.Qtype == dns.TypeAAAA {
			rr, _ := dns.NewRR(fmt.Sprintf("%s 60 IN AAAA ::", q.Name))
			msg.Answer = append(msg.Answer, rr)
		}
	}
	w.WriteMsg(msg)
}

func (h *Handler) getFromCache(key string, id uint16) *dns.Msg {
	h.cacheMu.RLock()
	defer h.cacheMu.RUnlock()
	if entry, found := h.cache[key]; found {
		if time.Now().Before(entry.expiresAt) {
			resp := entry.msg.Copy()
			resp.Id = id
			return resp
		}
	}
	return nil
}

func (h *Handler) addToCache(key string, msg *dns.Msg) {
	if len(msg.Answer) == 0 {
		return
	}

	minTTL := uint32(DefaultTTL)
	for _, rr := range msg.Answer {
		if rr.Header().Ttl < minTTL && rr.Header().Ttl > 0 {
			minTTL = rr.Header().Ttl
		}
	}

	h.cacheMu.Lock()
	defer h.cacheMu.Unlock()

	if len(h.cache) >= MaxCacheEntries {
		oldest := h.cacheKeys[0]
		delete(h.cache, oldest)
		h.cacheKeys = h.cacheKeys[1:]
	}

	h.cache[key] = cacheEntry{
		msg:       msg.Copy(),
		expiresAt: time.Now().Add(time.Duration(minTTL) * time.Second),
	}
	h.cacheKeys = append(h.cacheKeys, key)
}

func (h *Handler) resolveParallel(r *dns.Msg) *dns.Msg {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	resChan := make(chan *dns.Msg, len(h.Upstreams))

	for _, upstream := range h.Upstreams {
		go func(u string) {
			// Using custom exchange to ensure context cancellation closes the socket
			reply := h.exchangeWithContext(ctx, r, u)
			if reply != nil {
				select {
				case resChan <- reply:
				case <-ctx.Done():
				}
			}
		}(upstream)
	}

	select {
	case reply := <-resChan:
		return reply
	case <-time.After(UpstreamTimeout):
		fail := new(dns.Msg)
		fail.SetReply(r)
		fail.SetRcode(r, dns.RcodeServerFailure)
		return fail
	}
}

func (h *Handler) exchangeWithContext(ctx context.Context, r *dns.Msg, addr string) *dns.Msg {
	// Wrapper to ensure that if the first upstream wins, we don't leave 
	// other sockets hanging indefinitely.
	done := make(chan *dns.Msg, 1)
	go func() {
		reply, _, err := h.dotClient.Exchange(r, addr)
		if err == nil {
			done <- reply
		} else {
			done <- nil
		}
	}()

	select {
	case msg := <-done:
		return msg
	case <-ctx.Done():
		return nil
	}
}
