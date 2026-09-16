#!/usr/bin/env bash
# Blazing fast pure-bash replacement for media.py
# Eliminates ~100ms Python cold-boot input lag on media key presses

ACTION="$1"
MPV_SOCKET="/tmp/mpvsocket"

if [ -z "$ACTION" ]; then
    notify-send "Media Control" "No action specified"
    exit 1
fi

system_audio_command() {
    if command -v wpctl >/dev/null 2>&1; then
        case "$1" in
            volup) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ ;;
            voldown) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
            mute) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
        esac
    elif command -v pactl >/dev/null 2>&1; then
        case "$1" in
            volup) pactl set-sink-volume @DEFAULT_SINK@ +5% ;;
            voldown) pactl set-sink-volume @DEFAULT_SINK@ -5% ;;
            mute) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
        esac
    fi
}

# If it's a volume command, run it immediately system-wide
if [[ "$ACTION" == "volup" || "$ACTION" == "voldown" || "$ACTION" == "mute" ]]; then
    system_audio_command "$ACTION"
    exit 0
fi

# Check MPV
if [ -S "$MPV_SOCKET" ] && pgrep -f "mpv --input-ipc-server=$MPV_SOCKET" >/dev/null; then
    case "$ACTION" in
        toggle) CMD='["cycle", "pause"]' ;;
        next) CMD='["playlist-next"]' ;;
        prev) CMD='["playlist-prev"]' ;;
        stop) CMD='["stop"]' ;;
        kill) CMD='["quit"]' ;;
        shuffle) CMD='["cycle", "shuffle"]' ;;
        repeat) CMD='["cycle", "loop-playlist"]' ;;
        *) notify-send "Media Control" "Unknown action: $ACTION"; exit 1 ;;
    esac
    echo "{ \"command\": $CMD }" | socat - "$MPV_SOCKET" >/dev/null 2>&1
    exit 0
fi

# Check MPD
if mpc status 2>/dev/null | grep -qEo '\[(playing|paused)\]'; then
    case "$ACTION" in
        toggle) mpc toggle -q ;;
        next) mpc next -q ;;
        prev) mpc prev -q ;;
        stop|kill) mpc stop -q ;;
        shuffle) mpc random -q ;;
        repeat) mpc repeat -q ;;
    esac
    exit 0
fi
