#!/bin/bash

set -e 

echo "Checking for existing Rust installation..."
if command -v rustup &>/dev/null; then
    echo "Removing existing Rust installation..."
    rustup self uninstall -y
fi

echo "Detecting system architecture..."
ARCH=$(uname -m)

case "$ARCH" in
    x86_64) ARCH="x86_64" ;;
    arm64 | aarch64) ARCH="aarch64" ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

echo "Downloading and running Rust installer..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

echo "Verifying Rust installation..."
if ! command -v rustc &>/dev/null; then
    echo "Rust installation verification failed."
    exit 1
fi

rustc --version
echo "Rust installation complete!"
