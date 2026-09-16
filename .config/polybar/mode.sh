#!/bin/bash

default_mode="#6e6a86"
other_modes="#e06c75"

print_mode() {
    local mode="Default"
    local color=$default_mode
    if [ -f /tmp/i3_mode ]; then
        mode=$(cat /tmp/i3_mode)
        [ -z "$mode" ] && mode="Default"
    fi
    if [ "$mode" != "Default" ]; then
        color=$other_modes
    else
        color=$default_mode
    fi
    echo "%{F$color}$mode%{F-}"
}

print_mode

# Run event-driven listener (No fallbacks)
inotifywait -q -m -e modify,close_write,create /tmp/i3_mode 2>/dev/null | while read -r event; do
    print_mode
done
