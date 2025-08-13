#!/bin/bash

set -e  # Exit on error

echo "Checking if Neovim is already installed..."
if command -v nvim >/dev/null; then
    echo "Removing existing Neovim installation..."
    sudo apt remove --purge -y neovim || true
    echo "Neovim removed successfully."
else
    echo "No existing Neovim installation found."
fi

echo "Removing existing Neovim configuration and data directories..."
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

echo "Installing dependencies..."
sudo apt update
sudo apt install -y ninja-build gettext cmake unzip curl git build-essential

echo "Cloning Neovim repository..."
rm -rf neovim
git clone --depth=1 https://github.com/neovim/neovim.git
cd neovim

echo "Building Neovim..."
make CMAKE_BUILD_TYPE=Release

echo "Installing Neovim..."
sudo make install

echo "Verifying Neovim installation..."
if command -v nvim >/dev/null; then
    echo "Neovim installed successfully! Version:"
    nvim --version
else
    echo "Neovim installation failed. Exiting."
    exit 1
fi

echo "Setting up telescope-fzf-native.nvim plugin..."
TELESCOPE_PLUGIN_DIR="$HOME/.local/share/nvim/lazy/telescope-fzf-native.nvim"
if [ ! -d "$TELESCOPE_PLUGIN_DIR" ]; then
    echo "Cloning telescope-fzf-native.nvim..."
    git clone https://github.com/nvim-telescope/telescope-fzf-native.nvim.git "$TELESCOPE_PLUGIN_DIR"
else
    echo "telescope-fzf-native.nvim is already installed."
fi

echo "Compiling telescope-fzf-native.nvim..."
cd "$TELESCOPE_PLUGIN_DIR" && make && cd -

echo "Cleaning up..."
cd ..
rm -rf neovim

echo "Neovim installation complete!"
