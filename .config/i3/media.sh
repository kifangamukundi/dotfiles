#!/usr/bin/env bash
set -euo pipefail

MPV_SOCKET="/tmp/mpvsocket"

is_mpd_active() {
    mpc status >/dev/null 2>&1 && [[ -n "$(mpc status | grep -E 'playing|paused')" ]]
}

is_mpv_active() {
    [[ -e "$MPV_SOCKET" ]] && pgrep -f "mpv --input-ipc-server=$MPV_SOCKET" >/dev/null 2>&1
}

action="${1:-}"

if is_mpv_active; then
    case "$action" in
        toggle)   echo '{ "command": ["cycle", "pause"] }' | socat - "$MPV_SOCKET" ;;
        next)     echo '{ "command": ["playlist-next"] }'   | socat - "$MPV_SOCKET" ;;
        prev)     echo '{ "command": ["playlist-prev"] }'   | socat - "$MPV_SOCKET" ;;
        stop)     echo '{ "command": ["stop"] }'            | socat - "$MPV_SOCKET" ;;
        kill)     echo '{ "command": ["quit"] }'            | socat - "$MPV_SOCKET" ;;
        volup)    echo '{ "command": ["add", "volume", 5] }'  | socat - "$MPV_SOCKET" ;;
        voldown)  echo '{ "command": ["add", "volume", -5] }' | socat - "$MPV_SOCKET" ;;
        mute)     echo '{ "command": ["cycle", "mute"] }'     | socat - "$MPV_SOCKET" ;;
        shuffle)  echo '{ "command": ["cycle", "shuffle"] }' | socat - "$MPV_SOCKET" ;;
        repeat)   echo '{ "command": ["cycle", "loop-playlist"] }' | socat - "$MPV_SOCKET" ;;
    esac
elif is_mpd_active; then
    case "$action" in
        toggle)   mpc toggle ;;
        next)     mpc next ;;
        prev)     mpc prev ;;
        stop)     mpc stop ;;
        kill)     mpc stop ;;
        volup)    mpc volume +5 ;;
        voldown)  mpc volume -5 ;;
        mute)     mpc volume 0 ;;
        shuffle)  mpc random ;;
        repeat)   mpc repeat ;;
    esac
else
    case "$action" in
        volup)   pactl set-sink-volume @DEFAULT_SINK@ +5% ;;
        voldown) pactl set-sink-volume @DEFAULT_SINK@ -5% ;;
        mute)    pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
        *)       notify-send "Media Control" "No active MPV or MPD session" ;;
    esac
fi
