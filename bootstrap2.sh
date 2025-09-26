#!/usr/bin/env bash
set -e
set -u

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

echo "Apps installed"
