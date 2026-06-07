package main

import (
	"flag"
	"github.com/kifanga/habit/internal/blocklist"
	"github.com/kifanga/habit/internal/config"
	"github.com/kifanga/habit/internal/dns"
	"log"
)

func main() {
	configPath := flag.String("config", "configs/config.yaml", "Path to configuration file")
	flag.Parse()

	cfg, err := config.Load(*configPath)
	if err != nil {
		log.Fatalf("Failed to load config: %v", err)
	}

	manager := blocklist.NewManager(cfg)

	handler := dns.NewHandler(cfg.Upstream, cfg.BlockMode, manager)
	server := dns.NewServer(cfg.Listen, handler)

	log.Printf("Starting habit on %s (Whitelist-Only Mode)", cfg.Listen)
	if err := server.ListenAndServe(); err != nil {
		log.Fatalf("Server failed: %v", err)
	}
}
