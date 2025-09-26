#!/bin/bash
# Usage: ./install-nerd-font JetBrainsMono 3.2.1 install or remove

install_nerd_font() {
  FONT_NAME="$1"
  VERSION="$2"
  FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v$VERSION/$FONT_NAME.zip"

  TEMP_DIR=$(mktemp -d)
  wget -q --show-progress "$FONT_URL" -O "$TEMP_DIR/$FONT_NAME.zip"
  unzip -q "$TEMP_DIR/$FONT_NAME.zip" -d "$TEMP_DIR/$FONT_NAME/"
  
  # Global font directory
  FONT_DIR="/usr/local/share/fonts/$FONT_NAME"
  sudo mkdir -p "$FONT_DIR"
  sudo mv "$TEMP_DIR/$FONT_NAME/"* "$FONT_DIR/"
  
  # Refresh font cache
  sudo fc-cache -fv
  fc-list | grep "Nerd Font"
  
  rm -rf "$TEMP_DIR"
  echo "$FONT_NAME Nerd Font version $VERSION installed globally!"
}

remove_nerd_font() {
  FONT_NAME="$1"
  FONT_DIR="/usr/local/share/fonts/$FONT_NAME"

  if [ -d "$FONT_DIR" ]; then
    echo "Removing $FONT_NAME Nerd Font from system fonts..."
    sudo rm -rf "$FONT_DIR"
    sudo fc-cache -fv
    echo "$FONT_NAME Nerd Font removal completed!"
  else
    echo "$FONT_NAME Nerd Font not found in system fonts."
  fi
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
