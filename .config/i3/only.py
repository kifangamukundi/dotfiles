#!/home/kifanga/virtualenvironment/bin/python

import i3ipc

def close_other_windows_in_workspace():
    i3 = i3ipc.Connection()

    # Get the focused window
    focused = i3.get_tree().find_focused()
    if not focused or not focused.workspace():
        return

    workspace = focused.workspace()
    focused_id = focused.id

    # Iterate over all windows in the workspace
    for node in workspace.leaves():
        if node.window and node.id != focused_id:
            try:
                node.command('kill')
            except Exception as e:
                print(f"Error closing window {node.window}: {e}")

if __name__ == "__main__":
    close_other_windows_in_workspace()
