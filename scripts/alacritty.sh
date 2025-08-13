#!/bin/bash

set -e

echo "Updating system package list..."
sudo apt update

echo "Installing Alacritty dependencies..."
sudo apt install -y cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 openssl

echo "Cloning Alacritty repository..."
git clone https://github.com/alacritty/alacritty.git
cd alacritty

echo "Setting Rust to stable version..."
rustup override set stable
rustup update stable

echo "Building Alacritty..."
cargo build --release

echo "Installing Alacritty binary..."
sudo cp target/release/alacritty /usr/local/bin

echo "Setting up Alacritty desktop entry..."
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

echo "Verifying installation..."
if command -v alacritty &>/dev/null; then
    echo "Alacritty installed successfully!"
    infocmp alacritty
else
    echo "Alacritty installation failed."
    exit 1
fi

echo "Cleaning up..."

cargo clean

cd ..

rm -rf alacritty

echo "Cleanup complete!"
