#!/bin/bash

set -e

FZF_VERSION="0.60.3"
FZF_TAR="fzf-${FZF_VERSION}-linux_amd64.tar.gz"
FZF_URL="https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/${FZF_TAR}"
INSTALL_DIR="/usr/local/bin"

curl -LO "$FZF_URL"
tar -xzf "$FZF_TAR"
sudo cp fzf "$INSTALL_DIR/"
sudo chmod +x "$INSTALL_DIR/fzf"
rm -f "$FZF_TAR" fzf

echo "FZF Installed: $(fzf --version)"

sudo apt update
sudo apt install -y bat fd-find

sudo ln -sf /usr/bin/batcat /usr/bin/bat
sudo ln -sf /usr/bin/fdfind /usr/bin/fd

echo "Setup complete."
