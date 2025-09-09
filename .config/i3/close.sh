#!/bin/bash

# Get the name of the currently focused workspace
WORKSPACE_NAME=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

# Check if the workspace name is empty
if [ -z "$WORKSPACE_NAME" ]; then
    exit 1
fi

# Kill all windows on the current workspace
i3-msg "[workspace=$WORKSPACE_NAME] kill"
