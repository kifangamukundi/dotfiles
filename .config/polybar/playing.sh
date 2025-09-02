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

if pgrep -x "vlc" > /dev/null; then
  artist=$(playerctl --player=vlc metadata --format "{{ artist }}")
  title=$(playerctl --player=vlc metadata --format "{{ title }}")
  truncated_artist=$(truncate_string "$artist" "$MAX_LENGTH")
  truncated_title=$(truncate_string "$title" "$MAX_LENGTH")
  # echo "$truncated_artist"
  echo "$truncated_title" ":" "$truncated_artist"
else
  echo "Silence"
fi
