#!/bin/bash
# Wrapper to ensure only one instance of workspaces.py runs.
# Called via exec_always so on i3 reload the old daemon is killed first.
pkill -f "virtualenvironment.*workspaces.py" 2>/dev/null
sleep 0.1
exec ~/.config/i3/workspaces.py
