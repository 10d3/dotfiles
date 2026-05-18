#!/bin/bash

OUTPUT_DIR="$HOME/Videos"
mkdir -p "$OUTPUT_DIR"

PIDFILE="/tmp/gpu-screen-recorder.pid"

# ─── Stop recording if running ────────────────────────────
if [ -f "$PIDFILE" ]; then
    PID=$(cat "$PIDFILE")
    if kill -0 "$PID" 2>/dev/null; then           # process exists
        kill -SIGINT "$PID" 2>/dev/null
        rm -f "$PIDFILE"
        notify-send "Screen Recorder" "Recording saved."
        exit 0
    else
        rm -f "$PIDFILE"                           # stale lock file
    fi
fi


OUTPUT_FILE="$OUTPUT_DIR/rec_silent_$(date +%Y-%m-%d_%H-%M-%S).mp4"

notify-send "Screen Recorder" "Recording completely silent video..."
# Dropping the -a flags entirely records zero audio streams
gpu-screen-recorder -w screen -c mp4 -q ultra -o "$OUTPUT_FILE" &

REC_PID=$!
echo "$REC_PID" > "$PIDFILE"

# Wait for the recorder to finish (so the script exits when recording ends)
wait "$REC_PID"
rm -f "$PIDFILE"
