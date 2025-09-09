#!/home/kifanga/virtualenvironment/i3ipc/bin/python
import i3ipc
import subprocess
import time
import threading

i3 = i3ipc.Connection()

# Map workspace numbers to applications
WORKSPACE_APPS = {
    1: "alacritty",
    2: "google-chrome-stable",
    3: "firefox-esr",
    4: "mpv --idle",
}

# Track recently focused workspaces to prevent rapid re-launching
last_processed_workspace = None
last_processed_time = 0
DEBOUNCE_DELAY = 0.5  # seconds

def launch_application(app_cmd):
    """Launch application in background without blocking"""
    try:
        subprocess.Popen(
            app_cmd.split(),
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            start_new_session=True
        )
    except Exception as e:
        print(f"Error launching {app_cmd}: {e}")

def is_workspace_empty(workspace):
    """Check if workspace has any visible windows"""
    return not any(node.window for node in workspace.leaves())

def on_workspace_focus(i3, event):
    global last_processed_workspace, last_processed_time
    
    workspace_num = event.current.num
    current_time = time.time()
    
    # Debounce: prevent rapid consecutive calls to same workspace
    if (workspace_num == last_processed_workspace and 
        current_time - last_processed_time < DEBOUNCE_DELAY):
        return
    
    last_processed_workspace = workspace_num
    last_processed_time = current_time
    
    # Check if this workspace should auto-launch an app
    if workspace_num in WORKSPACE_APPS:
        # Use a thread to avoid blocking i3 events
        def delayed_launch():
            time.sleep(0.2)  # Wait for workspace switch to complete
            
            try:
                workspace = i3.get_tree().find_focused().workspace()
                if workspace and workspace.num == workspace_num and is_workspace_empty(workspace):
                    app_cmd = WORKSPACE_APPS[workspace_num]
                    launch_application(app_cmd)
            except Exception as e:
                print(f"Error in delayed launch: {e}")
        
        threading.Thread(target=delayed_launch, daemon=True).start()

def on_window_close(i3, event):
    """Switch to another workspace when current workspace becomes empty"""
    try:
        focused = i3.get_tree().find_focused()
        if not focused:
            return
            
        current_workspace = focused.workspace()
        if not current_workspace:
            return
            
        # Check if workspace is now empty
        if is_workspace_empty(current_workspace):
            # Find other non-empty workspaces
            workspaces = i3.get_workspaces()
            non_empty = [
                ws for ws in workspaces 
                if ws.num != current_workspace.num and not ws.focused
            ]
            
            if non_empty:
                # Switch to the most recently used non-empty workspace
                i3.command(f'workspace number {non_empty[0].num}')
    except Exception as e:
        print(f"Error in window close handler: {e}")

def main():
    print("Starting i3 workspace auto-launcher...")
    
    # Connect event handlers
    i3.on('workspace::focus', on_workspace_focus)
    i3.on('window::close', on_window_close)
    
    try:
        i3.main()
    except KeyboardInterrupt:
        print("Shutting down i3 workspace auto-launcher...")
    except Exception as e:
        print(f"Unexpected error: {e}")
    finally:
        i3.main_quit()

if __name__ == "__main__":
    main()
