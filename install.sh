sudo apt update
sudo apt install xorg git make gcc feh ffmpeg curl flameshot mpv alsa-utils pavucontrol kitty neofetch slock playerctl brightnessctl acpi wireless-tools brightnessctl acpi picom libxft-dev libxinerama-dev
#sudo pacman -Syu xorg git make gcc feh ffmpeg curl flameshot mpv amixer pavucontrol kitty neofetch slock playerctl brightnessctl acpi wireless_tools brightnessctl acpi
mkdir /home/$USER/.config/dwm
mv * /home/$USER/.config/dwm
cd /home/$USER/.config/dwm
mv rice/kitty ..
mv rice/picom.conf ..
cd dwm
cd dwm && sudo make clean install
cd ../dmenu && sudo make clean install
cd /home/$USER/
echo "alias startdwm='startx .xinitrcdwm'" >> .bashrc
echo -n "exec dwm & wmpid=\$!

sleep 3
/home/$USER/.config/dwm/rice/startupscript.sh

wait \$wmpid" >> .xinitrcdwm
rm -r DWM-Precooked-Rice
