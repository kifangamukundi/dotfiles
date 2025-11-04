#!/bin/bash

default_mode="#6e6a86"
other_modes="#e06c75"

mode="Default"
color=$default_fg

if [ -f /tmp/i3_mode ]; then
    mode=$(cat /tmp/i3_mode)

    if [ -z "$mode" ]; then
        mode="Default"
    fi
fi

if [ "$mode" != "Default" ]; then
    color=$other_modes
else
    color=$default_mode
fi

echo "%{F$color}$mode%{F-}"
