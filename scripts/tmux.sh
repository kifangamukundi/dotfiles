#!/bin/bash
# Usage: ./install-tmux.sh 3.5a

if command -v tmux >/dev/null; then
    sudo apt remove --purge -y tmux
    echo "tmux removed successfully."
else
    echo "tmux is not installed. Proceeding with installation..."
fi

TMUX_VERSION=${1:-3.5a}

TMUX_URL="https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz"

if ! wget --spider $TMUX_URL 2>/dev/null; then
    echo "Error: tmux version ${TMUX_VERSION} not found. Please check the version and try again."
    exit 1
fi

wget $TMUX_URL -O tmux-${TMUX_VERSION}.tar.gz
tar -xvf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
./configure
make
sudo make install

cd ..
rm -rf tmux-${TMUX_VERSION} tmux-${TMUX_VERSION}.tar.gz

if [ ! -d ~/.tmux/plugins/tpm ]; then
    mkdir -p ~/.tmux/plugins  
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "Tmux Plugin Manager (TPM) installed."
else
    echo "Tmux Plugin Manager (TPM) is already installed."
fi
