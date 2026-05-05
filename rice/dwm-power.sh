#!/bin/sh

# Show dmenu with blue theme
choice=$(printf "logout\nshutdown\nreboot\nhibernate" | dmenu -i -p "Action:" -nb "#46c8c0" -nf "#000000" -sb "#000000" -sf "#46c8c0")

case "$choice" in
    logout)
        # Kill specified apps gracefully
        killall -q brave-browser kitty feh picom  2>/dev/null
        # Kill DWM to return to TTY1
        killall dwm
        ;;
    shutdown)
        systemctl poweroff
        ;;
    reboot)
        systemctl reboot
        ;;
    hibernate)
        systemctl hibernate
        ;;
esac   
