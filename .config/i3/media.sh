#!/usr/bin/env bash
# media.sh — Blazing fast replacement for media.py.
# Exact same logic as media.py: MPV → MPD → system audio, in that priority order.

ACTION="$1"
MPV_SOCKET="/tmp/mpvsocket"

if [ -z "$ACTION" ]; then
    notify-send "Media Control" "No action specified"
    exit 1
fi

system_audio_command() {
    if command -v wpctl >/dev/null 2>&1; then
        case "$1" in
            volup)   wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ ;;
            voldown) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
            mute)    wpctl set-mute   @DEFAULT_AUDIO_SINK@ toggle ;;
        esac
    elif command -v pactl >/dev/null 2>&1; then
        case "$1" in
            volup)   pactl set-sink-volume @DEFAULT_SINK@ +5% ;;
            voldown) pactl set-sink-volume @DEFAULT_SINK@ -5% ;;
            mute)    pactl set-sink-mute   @DEFAULT_SINK@ toggle ;;
        esac
    fi
}

# ── MPV branch ────────────────────────────────────────────────────────────────
if [ -S "$MPV_SOCKET" ] && pgrep -f "mpv --input-ipc-server=$MPV_SOCKET" >/dev/null; then
    # Volume/mute always goes to system audio (same as media.py)
    if [[ "$ACTION" == "volup" || "$ACTION" == "voldown" || "$ACTION" == "mute" ]]; then
        system_audio_command "$ACTION"
        exit 0
    fi
    case "$ACTION" in
        toggle) CMD='["cycle", "pause"]' ;;
        next)   CMD='["playlist-next"]' ;;
        prev)   CMD='["playlist-prev"]' ;;
        stop)   CMD='["stop"]' ;;
        kill)   CMD='["quit"]' ;;
        shuffle) CMD='["cycle", "shuffle"]' ;;
        repeat)  CMD='["cycle", "loop-playlist"]' ;;
        *) notify-send "Media Control" "Unknown action: $ACTION"; exit 1 ;;
    esac
    echo "{ \"command\": $CMD }" | socat - "$MPV_SOCKET" >/dev/null 2>&1
    exit 0
fi

# ── MPD branch ────────────────────────────────────────────────────────────────
MPD_STATUS=$(mpc status 2>/dev/null)
if echo "$MPD_STATUS" | grep -qEo '\[(playing|paused)\]'; then
    # Volume/mute on MPD: route to system audio (same as media.py)
    if [[ "$ACTION" == "volup" || "$ACTION" == "voldown" || "$ACTION" == "mute" ]]; then
        system_audio_command "$ACTION"
        exit 0
    fi
    case "$ACTION" in
        toggle)  mpc toggle -q ;;
        next)    mpc next    -q ;;
        prev)    mpc prev    -q ;;
        stop)    mpc stop    -q ;;
        kill)    mpc stop    -q ;;   # mirrors: "kill": ["mpc","stop"] in media.py
        shuffle) mpc random  -q ;;
        repeat)  mpc repeat  -q ;;
    esac
    exit 0
fi

# ── Fallback: no media active, system audio only ──────────────────────────────
system_audio_command "$ACTION"
