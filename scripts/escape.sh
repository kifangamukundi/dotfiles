#!/bin/bash
set -e

# This updates /etc/default/keyboard

sudo sed -i -e '/XKBMODEL=/c\XKBMODEL="pc105"' \
           -e '/XKBLAYOUT=/c\XKBLAYOUT="us"' \
           -e '/XKBOPTIONS=/c\XKBOPTIONS="caps:escape"' \
           /etc/default/keyboard

echo "All configurations applied."
