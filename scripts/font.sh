#!/bin/bash
# Usage: ./install-nerd-font JetBrainsMono 3.2.1 install or remove

install_nerd_font() {
  FONT_NAME="$1"
  VERSION="$2"
  FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v$VERSION/$FONT_NAME.zip"
  
  TEMP_DIR=$(mktemp -d)
  wget -q --show-progress "$FONT_URL" -O "$TEMP_DIR/$FONT_NAME.zip"
  unzip -q "$TEMP_DIR/$FONT_NAME.zip" -d "$TEMP_DIR/$FONT_NAME/"
  mkdir -p "$HOME/.local/share/fonts/$FONT_NAME"
  mv "$TEMP_DIR/$FONT_NAME/"* "$HOME/.local/share/fonts/$FONT_NAME/"
  fc-cache -fv
  fc-list | grep "Nerd Font"
  rm -rf "$TEMP_DIR"
  echo "$FONT_NAME Nerd Font version $VERSION installation completed!"
}

remove_nerd_font() {
  FONT_NAME="$1"
  
  FONT_DIR="$HOME/.local/share/fonts/$FONT_NAME"
  if [ -d "$FONT_DIR" ]; then
    echo "Removing $FONT_NAME Nerd Font directory..."
    rm -rf "$FONT_DIR"
  else
    echo "$FONT_NAME Nerd Font directory does not exist."
  fi
  fc-cache -fv
  echo "$FONT_NAME Nerd Font removal completed!"
}

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 [font_name] [version] [install|remove]"
  exit 1
fi

FONT_NAME="$1"
VERSION="$2"
ACTION="$3"

if [ "$ACTION" == "install" ]; then
  install_nerd_font "$FONT_NAME" "$VERSION"
elif [ "$ACTION" == "remove" ]; then
  remove_nerd_font "$FONT_NAME"
else
  echo "Invalid action. Use 'install' or 'remove'."
  exit 1
fi
