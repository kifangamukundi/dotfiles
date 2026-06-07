package dns

import (
	"github.com/miekg/dns"
)

type Server struct {
	addr    string
	handler *Handler
}

func NewServer(addr string, handler *Handler) *Server {
	return &Server{
		addr:    addr,
		handler: handler,
	}
}

func (s *Server) ListenAndServe() error {
	server := &dns.Server{
		Addr:    s.addr,
		Net:     "udp",
		Handler: s.handler,
	}
	return server.ListenAndServe()
}
