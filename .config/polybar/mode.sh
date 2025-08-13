#!/bin/bash

default_color="#5f5faf"
system_color="#e07a5f"

window_color="#5fafaf"
resize_color="#f2b179"
workspace_color="#8ec07c"
move_color="#b988f2"
media_color="#7fb2f0"
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
    "Workspace")
        color=$workspace_color
        ;;
    "Move")
        color=$move_color
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
