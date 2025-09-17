#!/bin/bash
set -e

# This updates /etc/default/keyboard

# Get current X11 Model from localectl
CURRENT_MODEL=$(localectl status | grep "X11 Model" | awk '{print $NF}')

if [ -n "$CURRENT_MODEL" ]; then
    echo "Current X11 Model is: $CURRENT_MODEL. Using it for the keymap."
    sudo localectl --no-convert set-x11-keymap us "$CURRENT_MODEL" "" caps:escape
else
    echo "Could not detect X11 Model. Using 'pc105' as a fallback."
    sudo localectl --no-convert set-x11-keymap us pc105 "" caps:escape
fi

echo "All configurations applied."
