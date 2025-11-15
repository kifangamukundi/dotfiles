#!/bin/sh

xrdb -merge ~/.Xresources

~/.config/i3/rotate.sh &

picom --config ~/.config/picom/picom.conf &

# systemd user environment (required when using startx)
systemctl --user import-environment DISPLAY XAUTHORITY
systemctl --user start graphical-session.target

exec i3
