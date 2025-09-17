#!/usr/bin/env bash
set -e  # exit on error
set -u  # error on unset variables

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Build Essentials"
bash scripts/build.sh

echo "Setup"
bash scripts/setup.sh

echo "Swap Escape"
bash scripts/escape.sh

echo "Alacritty"
bash scripts/alacritty.sh

echo "Nerd Font"
bash scripts/font.sh "JetBrainsMono" "3.2.1" "install"

echo "Fzf"
bash scripts/fzf.sh

echo "Go"
bash scripts/go.sh

echo "Rust"
bash scripts/rust.sh

echo "Nodejs"
bash scripts/node.sh "20"

echo "Lua Rocks"
bash scripts/rocks.sh "5.1" "3.11.1"

echo "Vim"
bash scripts/vim.sh

echo "Nvim"
bash scripts/nvim.sh

echo "Starship"
bash scripts/star.sh

echo "Tmux"
bash scripts/tmux.sh "3.5a"

echo "Docker"
bash scripts/docker.sh

echo "Postres"
bash scripts/postgres.sh

echo "Pgadmin"
bash scripts/pgadmin.sh "web"

echo "Extras"
bash scripts/extras.sh "all"

echo "System setup complete!"
