#!/bin/bash

set -e  

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
echo "Latest Lazygit version: v${LAZYGIT_VERSION}"

curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

tar xf lazygit.tar.gz lazygit

sudo install lazygit -D -t /usr/local/bin/
echo "Lazygit installed successfully to /usr/local/bin"

rm -f lazygit.tar.gz lazygit

if command -v lazygit &>/dev/null; then
    echo "Lazygit is successfully installed! Version:"
    lazygit --version
else
    echo "Installation failed. Please check your setup."
    exit 1
fi
