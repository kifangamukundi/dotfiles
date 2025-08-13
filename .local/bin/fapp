#!/usr/bin/env bash

grep -r '^Exec=' /usr/share/applications ~/.local/share/applications 2>/dev/null \
  | sed 's/^.*Exec=//' \
  | sed 's/%.//' \
  | awk '{print $1}' \
  | sort -u \
  | fzf --prompt="Launch: "
