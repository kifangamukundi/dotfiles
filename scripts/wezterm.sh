#!/bin/bash

set -e

echo "Cloning WezTerm repository..."
rm -rf wezterm
git clone --depth=1 --branch=main --recursive https://github.com/wez/wezterm.git
cd wezterm

echo "Updating submodules..."
git submodule update --init --recursive

echo "Installing dependencies via get-deps..."
./get-deps

echo "Building WezTerm..."
cargo build --release

echo "Installing WezTerm binaries..."
sudo cp target/release/wezterm /usr/local/bin
sudo cp target/release/wezterm-mux-server /usr/local/bin
sudo cp target/release/wezterm-gui /usr/local/bin

echo "Setting up WezTerm desktop entry..."
mkdir -p ~/.local/share/applications
cp assets/wezterm.desktop ~/.local/share/applications/

echo "Verifying installation..."
if command -v wezterm &>/dev/null; then
    echo "WezTerm installed successfully!"
    wezterm --version
else
    echo "WezTerm installation failed."
    exit 1
fi

echo "Cleaning up..."
cd ..
rm -rf wezterm

echo "Cleanup complete!"
