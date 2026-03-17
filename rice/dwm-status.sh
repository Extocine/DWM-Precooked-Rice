#!/bin/bash

# Icons (Nerd Font)
ICON_CPU=""
ICON_RAM=""
ICON_WIFI=""
ICON_WIFI_OFF="󰖪"
ICON_BAT=""
ICON_CHG=""
ICON_VOL=""
ICON_MUTE=""
ICON_TIME=""
ICON_BRIGHT="󰃠"      # default brightness icon
ICON_MUSIC_PLAY=""
ICON_MUSIC_PAUSE=""
ICON_MUSIC_STOP=""

# Weather function (Nerd Font + hourly refresh)
get_weather() {
    CACHE="/tmp/dwm-weather"

    if [ ! -f "$CACHE" ] || [ $(( $(date +%s) - $(stat -c %Y "$CACHE") )) -gt 3600 ]; then
        DATA=$(curl -s "wttr.in/?format=%C+%t&u")

        CONDITION=$(echo "$DATA" | awk '{print tolower($1)}')
        TEMP=$(echo "$DATA" | awk '{print $2}' | sed 's/+//')

        case "$CONDITION" in
            *sun*|*clear*)
                ICON="" ;;
            *cloud*)
                ICON="" ;;
            *rain*|*drizzle*)
                ICON="" ;;
            *snow*)
                ICON="" ;;
            *storm*|*thunder*)
                ICON="" ;;
            *)
                ICON="" ;;
        esac

        echo "$ICON $TEMP" > "$CACHE"
    fi

    cat "$CACHE"
}

# Music function (playerctl)
get_music() {
    if playerctl status >/dev/null 2>&1; then
        STATUS=$(playerctl status 2>/dev/null)
        ARTIST=$(playerctl metadata artist 2>/dev/null)
        TITLE=$(playerctl metadata title 2>/dev/null)

        case "$STATUS" in
            Playing) ICON="$ICON_MUSIC_PLAY" ;;
            Paused) ICON="$ICON_MUSIC_PAUSE" ;;
            *) ICON="$ICON_MUSIC_STOP" ;;
        esac

        echo "$ICON $ARTIST - $TITLE"
    else
        echo "$ICON_MUSIC_STOP No Player"
    fi
}

# Brightness function (brightnessctl)
get_brightness() {
    if command -v brightnessctl >/dev/null; then
        BRIGHT=$(brightnessctl get)
        MAX=$(brightnessctl max)
        PERC=$(( BRIGHT * 100 / MAX ))

        # Simple brightness icon levels
        if [ "$PERC" -le 20 ]; then
            ICON="󰃜"
        elif [ "$PERC" -le 50 ]; then
            ICON="󰃟"
        elif [ "$PERC" -le 75 ]; then
            ICON="󰃠"
        else
            ICON="󰃡"
        fi

        echo "$ICON $PERC%"
    else
        echo "NoBright"
    fi
}

while true; do
    # Time
    TIME=$(date "+%a %b %d %-I:%M:%S %p")

    # CPU
    CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
    CPU=$(printf "%.0f" "$CPU")

    # RAM
    RAM=$(free -h | awk '/Mem:/ {print $3 "/" $2}')

    # WiFi
    WIFI_DEV=$(iwconfig 2>/dev/null | grep 'IEEE 802.11' | awk '{print $1}')
    if [ -n "$WIFI_DEV" ]; then
        SSID=$(iwconfig "$WIFI_DEV" | grep -o 'ESSID:"[^"]*"' | cut -d'"' -f2)
        if [ "$SSID" != "off/any" ]; then
            WIFI="$ICON_WIFI $SSID"
        else
            WIFI="$ICON_WIFI_OFF Disconnected"
        fi
    else
        WIFI="$ICON_WIFI_OFF No WiFi"
    fi

    # Battery
    if command -v acpi >/dev/null; then
        BAT_INFO=$(acpi -b)
        BAT_PERC=$(echo "$BAT_INFO" | grep -o '[0-9]\+%' )
        BAT_NUM=${BAT_PERC%\%}

        # Icon by percentage
        case $BAT_NUM in
            9[0-9]|100) ICON_BAT="" ;;
            7[0-9]|8[0-9]) ICON_BAT="" ;;
            5[0-9]|6[0-9]) ICON_BAT="" ;;
            3[0-9]|4[0-9]) ICON_BAT="" ;;
            *) ICON_BAT="" ;;
        esac

        if echo "$BAT_INFO" | grep -q "Charging"; then
            BAT=" $BAT_PERC"
        else
            BAT="$ICON_BAT $BAT_PERC"
        fi
    else
        BAT="NoBat"
    fi

    # Volume
    VOL_NUM=$(amixer get Master | awk -F'[][]' 'END{ print $2 }' | tr -d '%')
    MUTE=$(amixer get Master | awk -F'[][]' 'END{ print $4 }')

    if [ "$MUTE" = "off" ]; then
        VOL=" Mute"
    else
        if [ "$VOL_NUM" -eq 0 ]; then
            ICON_VOL=""
        elif [ "$VOL_NUM" -lt 50 ]; then
            ICON_VOL=""
        else
            ICON_VOL=""
        fi

        VOL="$ICON_VOL ${VOL_NUM}%"
    fi

    # Weather
    WEATHER=$(get_weather)

    # Music
    MUSIC=$(get_music)

    # Brightness
    BRIGHT=$(get_brightness)

    # Final Status
    STATUS="$WEATHER | $ICON_CPU $CPU% | $ICON_RAM $RAM | $WIFI | $BAT | $VOL | $BRIGHT | $MUSIC | $ICON_TIME $TIME"

    # Set DWM status
    xsetroot -name "$STATUS"
    sleep 1
done
