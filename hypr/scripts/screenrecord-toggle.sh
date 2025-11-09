#!/bin/bash

# --- Configuration ---
OUTPUT_DIR="$HOME/Videos/Screencasts"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
FILENAME="$OUTPUT_DIR/screencast-$DATE.mp4"

# --- Toggle Logic ---

# Check if wf-recorder is currently running
if pgrep -x "wf-recorder" > /dev/null; then
    # STOP RECORDING
    # Send SIGINT to correctly finalize the video file
    pkill -INT -x wf-recorder
    notify-send -t 3000 "Screen Recorder 🔴" "Recording stopped."
    exit 0
else
    # START RECORDING

    mkdir -p "$OUTPUT_DIR"

    # Start recording the selected area with slurp and include audio
    # The & runs the command in the background so Hyprland doesn't hang.
    wf-recorder -g "$(slurp)" --audio -f "$FILENAME" &

    notify-send -t 3000 "Screen Recorder 🟢" "Recording started. Select area."
fi
