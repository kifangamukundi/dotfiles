#!/bin/bash

echo "Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- --yes

source ~/.bashrc

echo "Starship installation successfully!"
