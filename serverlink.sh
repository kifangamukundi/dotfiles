#!/bin/bash

DOTFILES_DIR="$HOME/personal/dotfiles"
CONFIG_DIR="$HOME/.config"
LOCAL_DIR="$HOME/.local"

# Dry run mode
DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "Running in dry-run mode. No changes will be made."
fi

create_symlink() {
    local src="$1"
    local dest="$2"

    if [[ ! -e "$src" ]]; then
        echo "Warning: Source file/directory does not exist: $src"
        return
    fi

    if [[ -e "$dest" && ! -L "$dest" ]]; then
        echo "Backing up existing file: $dest -> $dest.bak"
        [[ "$DRY_RUN" == false ]] && mv "$dest" "$dest.bak"
    fi

    echo "Creating symlink: $dest -> $src"
    [[ "$DRY_RUN" == false ]] && ln -sf "$src" "$dest"
}

remove_symlink_if_exists() {
    local dest="$1"

    if [[ -L "$dest" ]]; then
        echo "Removing existing symlink: $dest"
        [[ "$DRY_RUN" == false ]] && rm "$dest"
    fi
}

mkdir -p "$CONFIG_DIR"
mkdir -p "$LOCAL_DIR/bin"
mkdir -p "$CONFIG_DIR/alacritty"
mkdir -p "$CONFIG_DIR/starship"
mkdir -p "$CONFIG_DIR/tmux"

remove_symlink_if_exists "$HOME/.zshrc"
remove_symlink_if_exists "$CONFIG_DIR/nvim"
remove_symlink_if_exists "$CONFIG_DIR/alacritty"
remove_symlink_if_exists "$CONFIG_DIR/starship"
remove_symlink_if_exists "$CONFIG_DIR/tmux/tmux.conf"
remove_symlink_if_exists "$LOCAL_DIR/bin"

create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.config/nvim" "$CONFIG_DIR/nvim"
create_symlink "$DOTFILES_DIR/.config/starship" "$CONFIG_DIR/starship"
create_symlink "$DOTFILES_DIR/.config/tmux.conf" "$CONFIG_DIR/tmux/tmuxserver.conf"
create_symlink "$DOTFILES_DIR/.config/alacritty" "$CONFIG_DIR/alacritty"
create_symlink "$DOTFILES_DIR/.local/bin" "$LOCAL_DIR/bin"

echo "Dotfiles symlinks created successfully!"
