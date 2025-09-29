#!/home/kifanga/virtualenvironment/bin/python

import i3ipc

def close_current_workspace_windows():
    i3 = i3ipc.Connection()

    # Get the currently focused workspace
    focused = i3.get_tree().find_focused()
    if not focused:
        return

    workspace = focused.workspace()
    if not workspace:
        return

    # Iterate over all windows in this workspace and close them
    for node in workspace.leaves():
        if node.window:  # only real windows, not containers
            try:
                node.command('kill')
            except Exception as e:
                print(f"Error closing window {node.window}: {e}")

if __name__ == "__main__":
    close_current_workspace_windows()
