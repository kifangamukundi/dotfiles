package blocklist

import (
	"github.com/kifanga/habit/internal/config"
	"strings"
	"sync"
	"time"
)

type Manager struct {
	mu          sync.RWMutex
	whitelist   map[string]struct{}
	config      *config.Config
	startupTime time.Time
}

const discoveryExpiry = 30 * time.Minute

var bundles = map[string][]string{
	"google-auth": {
		"google.com",
		"gstatic.com",
		"googleapis.com",
		"googleusercontent.com",
	},
	"youtube": {
		"youtube.com",
		"googlevideo.com",
		"ytimg.com",
		"ggpht.com",
	},
	"x": {
		"x.com",
		"twitter.com",
		"twimg.com",
		"t.co",
	},
	"reddit": {
		"reddit.com",
		"redditmedia.com",
		"redditstatic.com",
		"redd.it",
		"fastly.net",
		"rlcdn.com",
		"cloudflare.net",
	},
	"datafixa": {
		"datafixa.com",
	},
	"github": {
		"github.com",
		"githubassets.com",
		"githubusercontent.com",
		"github.io",
	},
	"debian": {
		"debian.org",
		"docker.com",
		"fastlydns.net",
		"postgresql.org",
		"pkg.dev",
	},
}

func NewManager(cfg *config.Config) *Manager {
	m := &Manager{
		whitelist:   make(map[string]struct{}),
		config:      cfg,
		startupTime: time.Now(),
	}
	m.rebuildWhitelist()
	return m
}

func (m *Manager) IsDiscoveryMode() bool {
	if !m.config.DiscoveryMode {
		return false
	}

	// Auto-Kill: If discovery has been running for more than 30 mins, disable it
	if time.Since(m.startupTime) > discoveryExpiry {
		return false
	}

	return true
}

func (m *Manager) IsWhitelisted(domain string) bool {
	m.mu.RLock()
	defer m.mu.RUnlock()

	domain = strings.ToLower(strings.TrimSuffix(domain, "."))

	// Exact match
	if _, ok := m.whitelist[domain]; ok {
		return true
	}

	// Check parent domains
	parts := strings.Split(domain, ".")
	for i := 1; i < len(parts); i++ {
		parent := strings.Join(parts[i:], ".")
		if _, ok := m.whitelist[parent]; ok {
			return true
		}
	}

	return false
}

func (m *Manager) rebuildWhitelist() {
	m.mu.Lock()
	defer m.mu.Unlock()
	m.whitelist = make(map[string]struct{})

	// Add domains from bundles
	for _, bName := range m.config.Bundles {
		if domains, ok := bundles[bName]; ok {
			for _, d := range domains {
				m.whitelist[strings.ToLower(strings.TrimSpace(d))] = struct{}{}
			}
		}
	}

	// Add individual domains
	for _, w := range m.config.Whitelist {
		m.whitelist[strings.ToLower(strings.TrimSpace(w))] = struct{}{}
	}
}
