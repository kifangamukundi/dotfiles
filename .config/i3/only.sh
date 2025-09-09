#!/bin/bash

# Get the name of the current (focused) workspace
CURRENT_WS=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

# Get the ID of the focused window
FOCUSED_ID=$(i3-msg -t get_tree | jq -r 'recurse(.nodes[]?) | select(.focused==true).id')

# Get the workspace node for the current workspace
WORKSPACE_NODE=$(i3-msg -t get_tree | jq --arg ws "$CURRENT_WS" '
  recurse(.nodes[]?) | select(.type=="workspace" and .name==$ws)
')

# Get IDs of all containers in that workspace
CONTAINERS=$(echo "$WORKSPACE_NODE" | jq -r 'recurse(.nodes[]?) | select(.type=="con" and .window?) | .id')

# Kill all containers except the focused one
for id in $CONTAINERS; do
    if [ "$id" != "$FOCUSED_ID" ]; then
        i3-msg "[con_id=$id] kill"
    fi
done
