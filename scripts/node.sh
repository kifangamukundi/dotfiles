#!/bin/bash
# Usage: ./install_node.sh 20

echo "Installing NVM (Node Version Manager)..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

if [ $# -ne 1 ]; then
  echo "Error: Please provide a Node.js version number (e.g., 20 or 18)."
  exit 1
fi

NODE_VERSION="$1"
echo "Installing Node.js version $NODE_VERSION..."
nvm install $NODE_VERSION

source ~/.bashrc

echo "Verifying Node.js installation..."
node -v
npm -v

echo "Node.js installation completed successfully!"
