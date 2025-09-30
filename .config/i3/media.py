#!/home/kifanga/virtualenvironment/bin/python

import os
import sys
import subprocess
import socket
import json
import shutil

MPV_SOCKET = "/tmp/mpvsocket"

# ---------------------------
# Helpers
# ---------------------------
def is_mpv_active():
    return (
        os.path.exists(MPV_SOCKET)
        and subprocess.call(
            ["pgrep", "-f", f"mpv --input-ipc-server={MPV_SOCKET}"],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        == 0
    )


def is_mpd_active():
    try:
        out = subprocess.check_output(
            ["mpc", "status"], stderr=subprocess.DEVNULL
        ).decode()
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
        subprocess.call(["notify-send", "Media Control", f"MPV error: {e}"])


def mpd_command(action):
    cmds = {
        "toggle": ["mpc", "toggle"],
        "next": ["mpc", "next"],
        "prev": ["mpc", "prev"],
        "stop": ["mpc", "stop"],
        "kill": ["mpc", "stop"],
        "shuffle": ["mpc", "random"],
        "repeat": ["mpc", "repeat"],
    }
    if action in cmds:
        subprocess.call(cmds[action])
    elif action in ["volup", "voldown", "mute"]:
        system_audio_command(action)

# ---------------------------
# Audio Fallbacks
# ---------------------------
def pactl_command(action):
    if action == "volup":
        subprocess.call(["pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%"])
    elif action == "voldown":
        subprocess.call(["pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%"])
    elif action == "mute":
        subprocess.call(["pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle"])


def wpctl_command(action):
    if action == "volup":
        subprocess.call(["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%+"])
    elif action == "voldown":
        subprocess.call(["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-"])
    elif action == "mute":
        subprocess.call(["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"])


def system_audio_command(action):
    """Auto-detect wpctl or pactl and use whichever is available."""
    if shutil.which("wpctl"):
        wpctl_command(action)
    elif shutil.which("pactl"):
        pactl_command(action)
    else:
        subprocess.call(["notify-send", "Media Control", "No wpctl or pactl available"])

# ---------------------------
# Main
# ---------------------------
def main():
    if len(sys.argv) < 2:
        subprocess.call(["notify-send", "Media Control", "No action specified"])
        return

    action = sys.argv[1]

    if is_mpv_active():
        mpv_map = {
            "toggle": ["cycle", "pause"],
            "next": ["playlist-next"],
            "prev": ["playlist-prev"],
            "stop": ["stop"],
            "kill": ["quit"],
            "shuffle": ["cycle", "shuffle"],
            "repeat": ["cycle", "loop-playlist"],
        }
        if action in ["volup", "voldown", "mute"]:
            system_audio_command(action)  # system volume so Polybar updates
        elif action in mpv_map:
            mpv_command(mpv_map[action])
        else:
            subprocess.call(["notify-send", "Media Control", f"Unknown action: {action}"])

    elif is_mpd_active():
        mpd_command(action)

    else:
        system_audio_command(action)


if __name__ == "__main__":
    main()
