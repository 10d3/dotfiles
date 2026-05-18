#!/bin/bash

OUTPUT_DIR="$HOME/Videos"
mkdir -p "$OUTPUT_DIR"
OUTPUT_FILE="$OUTPUT_DIR/crop_system_$(date +%Y-%m-%d_%H-%M-%S).mp4"

if pgrep -x "gpu-screen-recorder" > /dev/null; then
    killall -SIGINT gpu-screen-recorder
    notify-send "Screen Recorder" "Region recording saved."
    exit 0
fi

notify-send "Screen Recorder" "Select a region to record..."
REGION=$(slurp)
[ -z "$REGION" ] && { notify-send "Screen Recorder" "Canceled."; exit 1; }

notify-send "Screen Recorder" "Recording selected region + system audio..."
gpu-screen-recorder -w "$REGION" -c mp4 -q ultra -a "$(pactl get-default-sink).monitor" -o "$OUTPUT_FILE"
