#!/bin/sh
#requires xclip and dmenu as a dependency
emoji_file="$HOME/.cache/emoji_list"

if [ ! -f "$emoji_file" ]; then
    mkdir -p "$HOME/.cache"

    curl -s https://raw.githubusercontent.com/unicode-org/cldr/main/common/annotations/en.xml |
    awk '
    BEGIN {
        FS="[<>]"
    }

    /<annotation cp=/ {
        match($0, /cp="[^"]+"/)
        emoji = substr($0, RSTART+4, RLENGTH-5)

        # extract text between tags
        text = $3
        gsub(/\|/, " ", text)
        gsub(/^[ \t]+|[ \t]+$/, "", text)

        if (text != "") {
            print emoji " - " tolower(text)
        }
    }
    ' | sort -u > "$emoji_file"
fi

choice=$(cat "$emoji_file" | dmenu -i -l 15 -p "Search emoji" \
    -nb "#222222" \
    -nf "#bbbbbb" \
    -sb "#ffff00" \
    -sf "#000000")

if [ -n "$choice" ]; then
    echo "$choice" | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard
    pgrep -x dunst >/dev/null && notify-send "Copied" "$choice"
fi
