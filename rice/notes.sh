#!/bin/bash

# Base directory (override with export NOTES_DIR=... or pass as argument)
NOTES_DIR="${1:-/home/extocine/Programs/Sync/Notes}"

while true; do
    # Safely collect basenames of files & directories (excluding hidden ones)
    items=()
    shopt -s nullglob
    for item in "$NOTES_DIR"/*; do
        if [[ -e "$item" ]]; then
            name=$(basename "$item")
            if [[ "$name" != .* ]]; then
                items+=("$name")
            fi
        fi
    done
    shopt -u nullglob

    # Show dmenu and capture selection
    selection=$(printf "%s\n" "${items[@]}" | dmenu -p "Select Note or Directory:" \
          -nb "#222222" -nf "#bbbbbb" -sb "#FF69B4" -sf "#000000")

    # Exit if user presses Esc
    if [ -z "$selection" ]; then
        exit 0
    fi

    full_path="${NOTES_DIR%/}/$selection"

    if [[ -d "$full_path" ]]; then
        # ✅ User picked a directory: dive into it and show its contents
        NOTES_DIR="$full_path"
        continue
    elif [[ ! -e "$full_path" ]]; then
        # ✅ New file creation
        ext=""
        if [[ "$selection" == *".md" ]] || [[ "$selection" == *".minder" ]]; then
            ext=""  # Keep user-provided extension
        else
            ext=".md"
        fi

        new_file="${NOTES_DIR%/}/$selection$ext"
        touch "$new_file"  # Create file so apps don't throw errors on startup

        if [[ "$new_file" == *".minder" ]]; then
            minder "$new_file" &  # Minder app
        else
            marktext "$new_file" &  # MarkText app
        fi
    elif [[ -f "$full_path" ]]; then
        # ✅ Existing file: open directly
        if [[ "$full_path" == *".minder" ]]; then
            minder "$full_path" &
        else
            marktext "$full_path" &
        fi
    fi

    # If we reach here, it was a file. Exit cleanly as requested.
    exit 0
done
