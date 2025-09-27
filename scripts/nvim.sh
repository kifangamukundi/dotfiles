#!/bin/bash

set -e 

# make sure
# install node using the script first

if command -v nvim >/dev/null; then
    sudo apt remove --purge -y neovim || true
else
    echo "No existing Neovim installation found."
fi

rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

sudo apt update
sudo apt install -y ninja-build gettext cmake unzip curl git build-essential

rm -rf neovim
git clone --depth=1 https://github.com/neovim/neovim.git
cd neovim

make CMAKE_BUILD_TYPE=Release

sudo make install

if command -v nvim >/dev/null; then
    echo "Neovim installed successfully! Version:"
    nvim --version
else
    echo "Neovim installation failed. Exiting."
    exit 1
fi

cd ..
rm -rf neovim

echo "Neovim installation complete!"
