#!/usr/bin/env bash
set -e
set -u

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Build Essentials"
bash scripts/build.sh

echo "Setup"
bash scripts/setup.sh

echo "Swap Escape"
bash scripts/escape.sh

echo "System setup complete!"
