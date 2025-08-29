#!/bin/bash

default_color="#3e8fb0"
system_color="#eb6f92"

window_color="#eb6f92"
resize_color="#eb6f92"
media_color="#eb6f92"
unknown_color="#d65d0e"

# Default mode
mode="Default"
color=$default_color

if [ -f /tmp/i3_mode ]; then
    mode=$(cat /tmp/i3_mode)

    if [ -z "$mode" ]; then
        mode="Default"
        color=$default_color
    fi
else
    mode="Default"
    color=$default_color
fi

case "$mode" in
    "System")
        color=$system_color
        ;;
    "Window")
        color=$window_color
        ;;
    "Resize")
        color=$resize_color
        ;;
    "Media")
      color=$media_color
      ;;
    "Default")
        color=$default_color
        ;;
    *)
    color=$unknown_color
    ;;
esac

echo "%{F$color}$mode%{F-}"
