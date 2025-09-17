#!/bin/bash

set -e

CURRENT_MODEL=$(localectl status | grep "X11 Model" | awk '{print $3}')

if [ -n "$CURRENT_MODEL" ]; then
    echo "Current X11 Model is: $CURRENT_MODEL. Using it for the keymap."
    sudo localectl set-x11-keymap us $CURRENT_MODEL "" caps:escape
else
    echo "Could not detect X11 Model. Using 'pc105' as a fallback."
    sudo localectl set-x11-keymap us pc105 "" caps:escape
fi

echo "All configurations applied."
