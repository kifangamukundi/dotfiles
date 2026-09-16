#!/bin/bash
# close.sh — Kill all windows in the currently focused workspace.
# Mirrors close.py: iterates workspace leaves, kills all real windows.

TREE=$(i3-msg -t get_tree)

# Find the workspace name that contains the focused window
WS_NAME=$(echo "$TREE" | jq -r '
  first(
    .. | objects |
    select(.type? == "workspace") |
    select(
      [ .. | objects | select(.focused? == true and .window? != null) ] | length > 0
    ) |
    .name
  )
')

if [ -z "$WS_NAME" ] || [ "$WS_NAME" = "null" ]; then
    exit 0
fi

# Collect all window con_ids in that workspace and kill them
echo "$TREE" | jq -r --arg ws "$WS_NAME" '
  .. | objects |
  select(.type? == "workspace" and .name? == $ws) |
  [ .. | objects | select(.window? != null) | .id ] |
  .[]
' | xargs -r -I {} i3-msg "[con_id=\"{}\"] kill" >/dev/null
