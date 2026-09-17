#!/bin/bash

# Explicitly tell the installer where we want it (so it matches your .zshrc)
export NVM_DIR="$HOME/.config/nvm"

# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# in lieu of restarting the shell
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
