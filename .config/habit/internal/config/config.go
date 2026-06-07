package config

import (
	"gopkg.in/yaml.v3"
	"os"
	"time"
)

type Config struct {
	Listen        string        `yaml:"listen"`
	Upstream      []string      `yaml:"upstream"`
	BlockMode     string        `yaml:"block_mode"`
	Whitelist     []string      `yaml:"whitelist"`
	Bundles       []string      `yaml:"bundles"`
	DiscoveryMode bool          `yaml:"discovery_mode"`
	CommitDelay   time.Duration `yaml:"commit_delay"` // New: Wait before applying changes
	ModTime       time.Time     `yaml:"-"`            // Internal: When the file was last changed
}

func Load(path string) (*Config, error) {
	info, err := os.Stat(path)
	if err != nil {
		return nil, err
	}

	f, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer f.Close()

	var cfg Config
	if err := yaml.NewDecoder(f).Decode(&cfg); err != nil {
		return nil, err
	}
	cfg.ModTime = info.ModTime()
	return &cfg, nil
}
