#!/home/kifanga/virtualenvironment/bin/python

import os
import sys
import subprocess
import socket
import json

MPV_SOCKET = "/tmp/mpvsocket"

def is_mpv_active():
    return (
        os.path.exists(MPV_SOCKET) and
        subprocess.call(["pgrep", "-f", f"mpv --input-ipc-server={MPV_SOCKET}"],
                        stdout=subprocess.DEVNULL,
                        stderr=subprocess.DEVNULL) == 0
    )

def is_mpd_active():
    try:
        out = subprocess.check_output(["mpc", "status"], stderr=subprocess.DEVNULL).decode()
        return any(state in out for state in ["playing", "paused"])
    except Exception:
        return False

def mpv_command(command):
    try:
        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        sock.connect(MPV_SOCKET)
        msg = json.dumps({"command": command}) + "\n"
        sock.send(msg.encode())
        sock.close()
    except Exception as e:
        print(f"Error sending command to MPV: {e}")

def mpd_command(action):
    cmds = {
        "toggle":  ["mpc", "toggle"],
        "next":    ["mpc", "next"],
        "prev":    ["mpc", "prev"],
        "stop":    ["mpc", "stop"],
        "kill":    ["mpc", "stop"],
        "volup":   ["mpc", "volume", "+5"],
        "voldown": ["mpc", "volume", "-5"],
        "mute":    ["mpc", "volume", "0"],
        "shuffle": ["mpc", "random"],
        "repeat":  ["mpc", "repeat"],
    }
    if action in cmds:
        subprocess.call(cmds[action])

def pactl_command(action):
    if action == "volup":
        subprocess.call(["pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%"])
    elif action == "voldown":
        subprocess.call(["pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%"])
    elif action == "mute":
        subprocess.call(["pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle"])
    else:
        subprocess.call(["notify-send", "Media Control", "No active MPV or MPD session"])

def main():
    action = sys.argv[1] if len(sys.argv) > 1 else None
    if not action:
        return

    if is_mpv_active():
        mpv_map = {
            "toggle":   ["cycle", "pause"],
            "next":     ["playlist-next"],
            "prev":     ["playlist-prev"],
            "stop":     ["stop"],
            "kill":     ["quit"],
            "volup":    ["add", "volume", 5],
            "voldown":  ["add", "volume", -5],
            "mute":     ["cycle", "mute"],
            "shuffle":  ["cycle", "shuffle"],
            "repeat":   ["cycle", "loop-playlist"],
        }
        if action in mpv_map:
            mpv_command(mpv_map[action])
    elif is_mpd_active():
        mpd_command(action)
    else:
        pactl_command(action)

if __name__ == "__main__":
    main()
