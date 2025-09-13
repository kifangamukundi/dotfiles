#!/bin/bash

default_fg="#6e6a86"
session_fg="#393552"

mode="Default"
color=$default_fg

if [ -f /tmp/i3_mode ]; then
    mode=$(cat /tmp/i3_mode)

    if [ -z "$mode" ]; then
        mode="Default"
    fi
fi

if [ "$mode" != "Default" ]; then
    color=$session_fg
else
    color=$default_fg
fi

echo "%{F$color}$mode%{F-}"
