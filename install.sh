#!/bin/sh
sudo pacman --noconfirm -S git
git clone https://github.com/ljurk/dot ~/.dot
cd ~/.dot
sudo pacman --noconfirm -S $(cat packages.txt | sed -e '/^#/d' -e '/^$/d')
stow */

#yay
sudo pacman --noconfirm -S base-devel
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay && makepkg --noconfirm -si
cd ~/.dot
yay --noconfirm -S $(cat packages-aur.txt | sed -e '/^#/d' -e '/^$/d')

# lightdm
sudo systemctl enable lightdm.service

# install feather font
mkdir -p ~/.local/share/fonts/panels/
curl -s https://raw.githubusercontent.com/adi1090x/rofi/master/fonts/Icomoon-Feather.ttf > ~/.local/share/fonts/panels/icomoon-feather.ttf
