#!/usr/bin/env bash
set -e
set -u

# sudo dd if=~/Downloads/debian-13.1.0-amd64-netinst.iso of=/dev/sdb bs=4M status=progress oflag=sync

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Build Essentials"
bash scripts/build.sh

echo "Setup"
bash scripts/setup.sh

echo "Swap Escape"
bash scripts/escape.sh

echo "System setup complete!"
