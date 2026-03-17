#Fixes Slow GTK Apps
exec systemctl --user import-environment &

#Opens Terminals
kitty --detach --hold bash -c "tty-clock -stcC 6; exec bash"
kitty --detach --hold bash -c "htop; exec bash"
kitty --detach --hold bash

#Wallpaper
feh --bg-scale ~/Pictures/wallpapers/img.png & 

#Transparency
picom -b & 

#DWM Status Bar
~/.config/dwm/dwm-status.sh &
#while true; do xsetroot -name "$(date)"; sleep 1; done & 

#Opens File Manager
nemo & 

#Turn off screen blacking
xset -dpms
xset dpms 0 0 0 && xset s noblank  && xset s off

#Auto Opens Programs
syncthing &
brave-browser &
pavucontrol &
flameshot &

#Enable Bluetooth
blueman-applet &

#Notifications
dunst &

#Clipboard
parcellite &

#Opens Timeshift for backups
#sudo timeshift-gtk &
