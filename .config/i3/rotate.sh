#!/bin/bash

# Create a lock file to ensure only one instance of the script runs
LOCK_FILE="/tmp/i3_wallpaper_rotation.lock"

# If the lock file exists, another instance is already running, so exit.
if [ -e "$LOCK_FILE" ]; then
    echo "Another instance of the wallpaper rotation script is already running. Exiting."
    exit 0
fi

# Create the lock file
touch "$LOCK_FILE"

# Ensure the lock file is removed when the script exits, even if it's interrupted
trap "rm -f \"$LOCK_FILE\"" EXIT

WALLPAPER_DIR="$HOME/.config/i3/wallpapers"

while true; do
    feh --bg-scale "$(find "$WALLPAPER_DIR" -type f | shuf -n1)"
    sleep 600
done
