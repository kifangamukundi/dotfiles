#!/bin/sh

# 1. Set DPI before anything else
xrdb -merge ~/.Xresources

# Rate at which keyboard strokes are registered rate
xset r rate 300 50

# Screen saver activation after a given time
xset s 60

# 2. Start the wallpaper rotation script in the background
~/.config/i3/rotate.sh &

# 3. Start the picom compositor in the background
picom --config ~/.config/picom/picom.conf &

# other things if i decide to go with a graphical login manager
# sudo systemctl set-default graphical.target
# sudo systemctl set-default multi-user.target
# systemctl get-default

# 4. Finally, start the i3 window manager
exec i3
