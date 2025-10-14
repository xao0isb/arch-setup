#!/bin/bash

# some dirs
mkdir ~/.config
mkdir ~/Downloads
mkdir ~/Screenshots
# some dirs

# rights
sudo sed -i "s/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/" /etc/sudoers
sudo sed -i "s/^a ALL=(ALL) ALL/# a ALL=(ALL) ALL/" /etc/sudoers.d/00_a
# rights

sudo pacman -S --noconfirm i3-wm xterm

cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -i '/exec "$xterm" -geometry 80x66+0+0 -name login/s/^/# /' ~/.xinitrc
echo "exec i3" >> ~/.xinitrc

cp .bash_profile ~/
cp .bashrc ~/

# i3 + xterm setup
mkdir ~/.config/i3
cp config ~/.config/i3/

cp .Xresources ~/
# i3 + xterm setup

# font
git clone https://aur.archlinux.org/consolas-font.git ~/Downloads/escrotum-git
cd ~/Downloads/consolas-font
makepkg -si --noconfirm
cd ~
# font

sudo pacman -S --noconfirm dunst libnotify pipewire pipewire-pulse networkmanager vim less bc unzip openssh chromium libreoffice-still obs-studio

# dunst
mkdir ~/.config/dunst
cp dunstrc ~/.config/dunst/
# dunst

# brightness + volume scripts
mkdir ~/bin
cp update-brightness.sh ~/bin/
chmod +x ~/bin/update-brightness.sh
cp update-volume.sh ~/bin/
chmod +x ~/bin/update-volume.sh
# brightness + volume scripts

# locale setup
sudo localectl set-x11-keymap us,ru pc105+inet "" grp:win_space_toggle
# locale setup

# some network settigns
sudo systemctl enable NetworkManager
sudo cp 09-timezone /etc/NetworkManager/dispatcher.d/
sudo chmod +x /etc/NetworkManager/dispatcher.d/09-timezone
# some network settigns

systemctl --user enable ssh-agent

# touchpad settings
sudo cp 30-touchpad.conf /usr/share/X11/xorg.conf.d/
# touchpad settings

# escrotum
git clone https://aur.archlinux.org/escrotum-git.git ~/Downloads/escrotum-git
cd ~/Downloads/escrotum-git
makepkg -si --noconfirm
sudo pacman -S --noconfirm python-numpy
cd ~
# escrotum

mkdir ~/Projects

# git setup
for ARGUMENT in "$@"
do
    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    KEY_LENGTH=${#KEY}
    VALUE="${ARGUMENT:$KEY_LENGTH+1}"

    case $KEY in
        "ge")
            git config --global user.email $VALUE
            ;;
        "gn")
            git config --global user.name $VALUE
            ;;
    esac
done
# git setup

# pyenv
curl -fsSL https://pyenv.run | bash

echo "" >> .bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init - bash)"' >> ~/.bashrc

echo "" >> .bash_profile
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init - bash)"' >> ~/.bash_profile

sudo pacman -S --needed --noconfirm base-devel openssl zlib xz tk zstd
# pyenv

# zoom
git clone https://aur.archlinux.org/zoom.git ~/Downloads/zoom
cd ~/Downloads/zoom
makepkg -si --noconfirm
cd ~
# zoom

sudo reboot
