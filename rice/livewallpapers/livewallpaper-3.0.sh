#!/bin/bash

# -------- SETTINGS --------
FPS=30
SCALE="1920:1080"   # change if you want, or leave as-is
FRAME_TIME=$(awk "BEGIN {print 1/$FPS}")

# -------- KILL PREVIOUS INSTANCE --------
for pid in $(pidof -x "$(basename "$0")"); do
    if [ "$pid" != "$$" ]; then
        kill -9 "$pid"
    fi
done

VIDEO="$1"

if [ -z "$VIDEO" ]; then
    echo "Usage: $0 video.mp4"
    exit 1
fi

if [ ! -f "$VIDEO" ]; then
    echo "Video not found."
    exit 1
fi

# -------- CREATE RAM DIRECTORY --------
RAMDIR=$(mktemp -d /dev/shm/livewallpaperXXXX)

cleanup() {
    echo "Cleaning RAM..."
    rm -rf "$RAMDIR"
}
trap cleanup EXIT

echo "Using RAM directory: $RAMDIR"

# -------- EXTRACT FRAMES --------
echo "Extracting frames into RAM..."

ffmpeg -loglevel error \
-i "$VIDEO" \
-vf "fps=$FPS,scale=$SCALE" \
-pix_fmt rgb24 \
"$RAMDIR/frame_%06d.ppm"

# -------- LOAD FRAME LIST --------
mapfile -t wallpath < <(ls -v "$RAMDIR" | sed "s|^|$RAMDIR/|")

echo "Loaded ${#wallpath[@]} frames"
echo "Starting wallpaper loop..."

# -------- PLAYBACK LOOP --------
while true; do
    for frame in "${wallpath[@]}"; do

        start=$(date +%s.%N)

        feh --no-fehbg --bg-fill "$frame"

        end=$(date +%s.%N)
        elapsed=$(awk "BEGIN {print $end-$start}")
        sleep_time=$(awk "BEGIN {print $FRAME_TIME-$elapsed}")

        if (( $(echo "$sleep_time > 0" | bc -l) )); then
            sleep "$sleep_time"
        fi

    done
done
