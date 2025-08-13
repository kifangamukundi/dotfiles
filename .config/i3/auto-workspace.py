#!/home/kifanga/virtualenvironment/i3ipc/bin/python

import i3ipc

i3 = i3ipc.Connection()

def on_window_close(i3, event):
    current_workspace = i3.get_tree().find_focused().workspace()

    if any(node.window for node in current_workspace.leaves()):
        return

    non_empty = [
        ws for ws in i3.get_workspaces()
        if ws.num != current_workspace.num and ws.focused is False
    ]

    if non_empty:
        i3.command(f'workspace number {non_empty[-1].num}')

i3.on('window::close', on_window_close)
i3.main()
