#!/bin/bash

OUTPUT_DIR="$HOME/Videos"
mkdir -p "$OUTPUT_DIR"
PIDFILE="/tmp/gpu-screen-recorder.pid"

# ─── Stop recording if already running ──────────────────
if [ -f "$PIDFILE" ]; then
    PID=$(cat "$PIDFILE")
    if kill -0 "$PID" 2>/dev/null; then
        # Process exists → stop it gracefully
        kill -SIGINT "$PID" 2>/dev/null
        rm -f "$PIDFILE"
        notify-send "Screen Recorder" "Recording saved."
        exit 0
    else
        # Stale PID file → clean it up
        rm -f "$PIDFILE"
    fi
fi

# ─── Start new recording ─────────────────────────────────
OUTPUT_FILE="$OUTPUT_DIR/rec_dual_$(date +%Y-%m-%d_%H-%M-%S).mp4"

notify-send "Screen Recorder" "Recording screen + system + mic..."
gpu-screen-recorder \
    -w screen \
    -c mp4 \
    -q ultra \
    -a "$(pactl get-default-sink).monitor" \
    -a "$(pactl get-default-source)" \
    -o "$OUTPUT_FILE" &

REC_PID=$!
echo "$REC_PID" > "$PIDFILE"

wait "$REC_PID"
rm -f "$PIDFILE"
