import subprocess
import sys


def get_volume():
    result = subprocess.run(
        ["/usr/bin/wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"], capture_output=True
    )
    print(int(float(result.stdout.strip().split(b" ")[1]) * 100))


def get_mute():
    result = subprocess.run(
        ["/usr/bin/wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"], capture_output=True
    )
    print(b"[MUTED]" in result.stdout.strip())


def set_volume(value):
    subprocess.run(
        ["/usr/bin/wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", f"{value / 100}"]
    )


def toggle_mute():
    subprocess.run(["/usr/bin/wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"])


if __name__ == "__main__":
    if len(sys.argv) > 1:
        command = sys.argv[1]
        if command == "--get":
            get_volume()
        elif command == "--mute":
            get_mute()
        elif command == "--set" and len(sys.argv) > 2:
            set_volume(float(sys.argv[2]))
        elif command == "--toggle":
            toggle_mute()
        else:
            get_volume()
    else:
        get_volume()
