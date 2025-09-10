#!/bin/bash

DOTFILES_DIR="$HOME/personal/dotfiles"
CONFIG_DIR="$HOME/.config"
SSH_DIR="$HOME/.ssh"
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

mkdir -p "$SSH_DIR"
mkdir -p "$CONFIG_DIR"
mkdir -p "$LOCAL_DIR/bin"
mkdir -p "$LOCAL_DIR/share/fonts"
mkdir -p "$LOCAL_DIR/share/mpd"
mkdir -p "$CONFIG_DIR/alacritty"
mkdir -p "$CONFIG_DIR/starship"
mkdir -p "$CONFIG_DIR/polybar"
mkdir -p "$CONFIG_DIR/picom"
mkdir -p "$CONFIG_DIR/tmux"
mkdir -p "$CONFIG_DIR/mpd"
mkdir -p "$CONFIG_DIR/mpv"

remove_symlink_if_exists "$HOME/.bashrc"
remove_symlink_if_exists "$HOME/.inputrc"
remove_symlink_if_exists "$HOME/.xinitrc"
remove_symlink_if_exists "$HOME/.gitconfig"
remove_symlink_if_exists "$SSH_DIR/config"
remove_symlink_if_exists "$CONFIG_DIR/nvim"
remove_symlink_if_exists "$CONFIG_DIR/nvim-slim"
remove_symlink_if_exists "$CONFIG_DIR/gh"
remove_symlink_if_exists "$CONFIG_DIR/i3"
remove_symlink_if_exists "$CONFIG_DIR/polybar"
remove_symlink_if_exists "$CONFIG_DIR/picom"
remove_symlink_if_exists "$CONFIG_DIR/alacritty"
remove_symlink_if_exists "$CONFIG_DIR/starship"
remove_symlink_if_exists "$CONFIG_DIR/tmux/tmux.conf"
remove_symlink_if_exists "$CONFIG_DIR/mpd"
remove_symlink_if_exists "$CONFIG_DIR/mpv"
remove_symlink_if_exists "$LOCAL_DIR/bin"
remove_symlink_if_exists "$LOCAL_DIR/share/fonts"
remove_symlink_if_exists "$LOCAL_DIR/share/mpd"

create_symlink "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
create_symlink "$DOTFILES_DIR/.inputrc" "$HOME/.inputrc"
create_symlink "$DOTFILES_DIR/.xinitrc" "$HOME/.xinitrc"
create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
create_symlink "$DOTFILES_DIR/.ssh/config" "$SSH_DIR/config"
create_symlink "$DOTFILES_DIR/.config/nvim" "$CONFIG_DIR/nvim"
create_symlink "$DOTFILES_DIR/.config/nvim-slim" "$CONFIG_DIR/nvim-slim"
create_symlink "$DOTFILES_DIR/.config/gh" "$CONFIG_DIR/gh"
create_symlink "$DOTFILES_DIR/.config/i3" "$CONFIG_DIR/i3"
create_symlink "$DOTFILES_DIR/.config/starship" "$CONFIG_DIR/starship"
create_symlink "$DOTFILES_DIR/.config/tmux.conf" "$CONFIG_DIR/tmux/tmux.conf"
create_symlink "$DOTFILES_DIR/.config/alacritty" "$CONFIG_DIR/alacritty"
create_symlink "$DOTFILES_DIR/.config/polybar" "$CONFIG_DIR/polybar"
create_symlink "$DOTFILES_DIR/.config/picom" "$CONFIG_DIR/picom"
create_symlink "$DOTFILES_DIR/.config/mpd" "$CONFIG_DIR/mpd"
create_symlink "$DOTFILES_DIR/.config/mpd" "$CONFIG_DIR/mpv"
create_symlink "$DOTFILES_DIR/.local/bin" "$LOCAL_DIR/bin"
create_symlink "$DOTFILES_DIR/.local/share/fonts" "$LOCAL_DIR/share/fonts"
create_symlink "$DOTFILES_DIR/.local/share/mpd" "$LOCAL_DIR/share/mpd"

echo "Dotfiles symlinks created successfully!"
