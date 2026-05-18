#!/bin/bash

OUTPUT_DIR="$HOME/Videos"
mkdir -p "$OUTPUT_DIR"

PIDFILE="/tmp/gpu-screen-recorder.pid"

if [ -f "$PIDFILE"]; then
    PID=$(cat "$PIDFILE")
    if kill -0 "$PID" 2>/dev/null
      rm -f "$PIDFILE"
      notify-send "Screen Recorder" "Recording saved"
      exit 0
    else
      rm -f "$PIDFILE"
    fi
fi


OUTPUT_FILE="$OUTPUT_DIR/rec_mic_$(date +%Y-%m-%d_%H-%M-%S).mp4"

notify-send "Screen Recorder" "Recording screen + microphone..."
gpu-screen-recorder -w screen -c mp4 -q ultra -a "$(pactl get-default-source)" -o "$OUTPUT_FILE" &

REC_PID=$!
echo "$REC_PID" > "$PIDFILE"

# Wait for the recorder to finish (so the script exits when recording ends)
wait "$REC_PID"
rm -f "$PIDFILE"
