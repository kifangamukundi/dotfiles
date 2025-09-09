#!/bin/bash

set -e

sudo apt install -y cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 openssl

git clone https://github.com/alacritty/alacritty.git
cd alacritty

rustup override set stable
rustup update stable

cargo build --release

sudo cp target/release/alacritty /usr/local/bin

sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

if command -v alacritty &>/dev/null; then
    echo "Alacritty installed successfully!"
    infocmp alacritty
else
    echo "Alacritty installation failed."
    exit 1
fi

cargo clean

cd ..

rm -rf alacritty

echo "Cleanup complete!"
