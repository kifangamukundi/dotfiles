#!/bin/sh

# 1. Set DPI before anything else
xrdb -merge ~/.Xresources

# 3. Start the wallpaper rotation script in the background
~/.config/i3/rotate.sh &

# 4. Start the picom compositor in the background
picom --config ~/.config/picom/picom.conf &

# 5. Finally, start the i3 window manager
exec i3
