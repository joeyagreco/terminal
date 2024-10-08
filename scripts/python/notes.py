import argparse
import os
import subprocess
from datetime import datetime

from util import (
    print_color,
)

NOTES_DIR = os.environ.get("NOTES_PATH", "")
if NOTES_DIR == "":
    print_color("could not load notes path from $NOTES_PATH", color="red")
    exit(1)


def execute_command(command: str) -> str:
    try:
        result = subprocess.run(
            command, shell=True, check=True, text=True, capture_output=True
        )
    except subprocess.CalledProcessError as e:
        raise RuntimeError(f"command failed with error: {e}")

    return result.stdout


def initial_setup() -> None:
    # check if notes folder exists
    if not os.path.isdir(NOTES_DIR):
        # doesn't exist, do setup
        selection = input(f"create notes directory at '{NOTES_DIR}'?:\n(Y/n): ")
        if selection == "Y":
            execute_command(f"mkdir {NOTES_DIR}")
            print_color("created!", color="green")
        else:
            print_color("note creation cancelled", color="yellow")
            exit(0)


def create_new_note(*, name: str, extension: str) -> str:
    name = name
    name = name.replace(" ", "_")
    timestamp = datetime.now().strftime("%Y%m%dT%H%M%S")
    filename = f"{timestamp}_{name}.{extension}"
    new_note_path = os.path.join(NOTES_DIR, filename)
    open(new_note_path, "w")
    return new_note_path


def open_file_in_nvim(file_path: str) -> None:
    os.chdir(NOTES_DIR)
    subprocess.run(["nvim", file_path])


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-n", help="name of the note to be created", type=str, default="Untitled"
    )
    parser.add_argument(
        "-e",
        help="extension of the note to be created",
        default="txt",
        choices=["txt", "md"],
    )
    args = parser.parse_args()
    execute_command("clear")
    initial_setup()
    new_note_path = create_new_note(name=args.n, extension=args.e)
    open_file_in_nvim(new_note_path)
