#!/bin/bash

sudo sed -i "s/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/" /etc/sudoers
sudo sed -i "s/^a ALL=(ALL:ALL) ALL/# a ALL=(ALL:ALL) ALL/" /etc/sudoers.d/00_a

sudo pacman -S --noconfirm i3-wm xterm

cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -i '/exec "$xterm" -geometry 80x66+0+0 -name login/s/^/#/' ~/.xinitrc
echo "exec i3" >> ~/.xinitrc

cp .bash_profile ~/.bash_profile
cp .bashrc ~/.bashrc

mkdir ~/.config

mkdir ~/.config/i3
cp config ~/.config/i3/config

cp .Xresources ~/.Xresources
xrdb -merge ~/.Xresources

sudo pacman -S --noconfirm dunst libnotify pipewire pipewire-pulse networkmanager nano less bc chromium libreoffice-still obs-studio

mkdir ~/.config/dunst
cp dunstrc ~/.config/dunst/dunstrc

mkdir ~/bin
cp update-brightness.sh ~/bin/update-brightness.sh
chmod +x ~/bin/update-brightness.sh
cp update-volume.sh ~/bin/update-volume.sh
chmod +x ~/bin/update-volume.sh

sudo localectl set-x11-keymap us,ru pc105+inet "" grp:win_space_toggle

sudo systemctl enable NetworkManager
sudo cp 09-timezone /etc/NetworkManager/dispatcher.d/09-timezone
sudo chmod +x /etc/NetworkManager/dispatcher.d/09-timezone

sudo reboot
