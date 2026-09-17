#!/usr/bin/env bash
# link-server.sh — Symlink server-specific dotfiles only.
set -euo pipefail

# We assume dotfiles are ALWAYS located here, even on the server.
DOTFILES_DIR="$HOME/personal/dotfiles"

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "Running in dry-run mode. No changes will be made."
fi

create_symlink() {
    local src="$1"
    local dest="$2"

    if [[ ! -e "$src" ]]; then
        echo "  ⚠ Source does not exist, skipping: $src"
        return
    fi

    if [[ -e "$dest" && ! -L "$dest" ]]; then
        echo "  ↩ Backing up: $dest → $dest.bak"
        [[ "$DRY_RUN" == false ]] && mv "$dest" "$dest.bak"
    fi

    echo "  → $dest"
    [[ "$DRY_RUN" == false ]] && ln -sf "$src" "$dest"
}

echo "▶ Linking server shell configs..."
create_symlink "$DOTFILES_DIR/.zshrc-server"   "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.bashrc-server"  "$HOME/.bashrc"
create_symlink "$DOTFILES_DIR/.gitconfig-server" "$HOME/.gitconfig"

echo ""
echo "▶ Linking server tools..."
mkdir -p "$HOME/.config/tmux"
create_symlink "$DOTFILES_DIR/.config/tmux-server.conf" "$HOME/.config/tmux/tmux.conf"
create_symlink "$DOTFILES_DIR/.config/starship" "$HOME/.config/starship"

echo ""
echo "✅ Server shell configs linked successfully!"
echo "   Run 'source ~/.zshrc' or 'source ~/.bashrc' to apply."
