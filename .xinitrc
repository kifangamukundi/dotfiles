#!/bin/sh

# Start the wallpaper rotation script in the background
~/.config/i3/rotate.sh &

# Start the picom compositor in the background
picom --config ~/.config/picom/picom.conf &

# Finally, execute the i3 window manager
exec i3
