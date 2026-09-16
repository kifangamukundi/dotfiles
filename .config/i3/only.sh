#!/bin/bash
# only.sh — Kill all windows in focused workspace EXCEPT the focused one.
# Mirrors only.py: keeps the focused window, kills everything else.

TREE=$(i3-msg -t get_tree)

# Find the focused window's con_id (integer)
FOCUSED_ID=$(echo "$TREE" | jq -r '
  first(.. | objects | select(.focused? == true and .window? != null) | .id)
')

if [ -z "$FOCUSED_ID" ] || [ "$FOCUSED_ID" = "null" ]; then
    exit 0
fi

# Find workspace name containing the focused window
WS_NAME=$(echo "$TREE" | jq -r --argjson fid "$FOCUSED_ID" '
  first(
    .. | objects |
    select(.type? == "workspace") |
    select([ .. | objects | select(.id? == $fid) ] | length > 0) |
    .name
  )
')

if [ -z "$WS_NAME" ] || [ "$WS_NAME" = "null" ]; then
    exit 0
fi

# Kill all windows in that workspace except the focused one
echo "$TREE" | jq -r --arg ws "$WS_NAME" --argjson fid "$FOCUSED_ID" '
  .. | objects |
  select(.type? == "workspace" and .name? == $ws) |
  [ .. | objects | select(.window? != null and .id? != $fid) | .id ] |
  .[]
' | xargs -r -I {} i3-msg "[con_id=\"{}\"] kill" >/dev/null
