#!/usr/bin/env bash
set -e
set -u

# First make sure do do this before running this script
# ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/github_key_name
# cat ~/.ssh/github_key_name.pub and add to github
# ssh -T git@github.com

# Then go, rust, node, extras, nvim, escape 

echo "Nerd Font"
bash scripts/font.sh "JetBrainsMono" "3.2.1" "install"

echo "Fzf"
bash scripts/fzf.sh

echo "Lua Rocks"
bash scripts/rocks.sh "5.1" "3.11.1"

echo "Vim"
bash scripts/vim.sh

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

echo "Apps installed"
