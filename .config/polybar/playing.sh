#!/usr/bin/env bash

MAX_LENGTH=20

truncate_string() {
    local string="$1"
    local max_length="$2"
    if [[ ${#string} -gt "$max_length" ]]; then
        echo "${string:0:$max_length}..."
    else
        echo "$string"
    fi
}

get_mpv_status() {
    local mpv_socket="/tmp/mpvsocket"
    local response=""

    if pgrep -f "mpv --input-ipc-server=$mpv_socket" >/dev/null; then
        response=$(echo '{ "command": ["get_property", "media-title"] }' | socat - "$mpv_socket" 2>/dev/null)
        local title=$(echo "$response" | grep -oP '"data":"\K[^"]*')
        local is_paused=$(echo '{ "command": ["get_property", "pause"] }' | socat - "$mpv_socket" 2>/dev/null | grep -oP '"data":\K(true|false)')

        if [[ -n "$title" ]]; then
            if [[ "$is_paused" == "true" ]]; then
                echo "Paused: $(truncate_string "$title" "$MAX_LENGTH")"
            else
                echo "Video: $(truncate_string "$title" "$MAX_LENGTH")"
            fi
            return 0
        fi
    fi
    return 1
}

main() {
    # 1. First, check for a running MPV video.
    if get_mpv_status; then
        exit 0
    fi

    # 2. If no MPV video is found, check for a running MPD song.
    local current_song=$(mpc current)
    local status=$(mpc status | grep -Eo '\[(playing|paused)\]')

    if [[ -n "$current_song" && "$status" == "[playing]" ]]; then
        if [[ "$current_song" == *" - "* ]]; then
            local artist="${current_song%% - *}"
            local title="${current_song##* - }"
        else
            local artist="Unknown"
            local title="$current_song"
        fi

        local truncated_artist=$(truncate_string "$artist" "$MAX_LENGTH")
        local truncated_title=$(truncate_string "$title" "$MAX_LENGTH")

        echo "Music: $truncated_title by $truncated_artist"
    elif [[ -n "$current_song" && "$status" == "[paused]" ]]; then
        echo "Paused: $(truncate_string "$current_song" "$MAX_LENGTH")"
    else
        echo "Silence"
    fi
}

main
