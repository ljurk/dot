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

# enable login manager
sudo rm /etc/pam.d/ly
sudo ln -s "$(pwd)/ly/pam" /etc/pam.d/ly
sudo systemctl enable ly.service

# install feather font
mkdir -p ~/.local/share/fonts/panels/
curl -s https://raw.githubusercontent.com/adi1090x/rofi/master/fonts/Icomoon-Feather.ttf > ~/.local/share/fonts/panels/icomoon-feather.ttf

# openvpn
nmcli connection import type openvpn file ~/.config/vpn/tud.ovpn || true

# passwordless pacman
sudo sh -c 'echo "%wheel ALL=(ALL) NOPASSWD: /usr/bin/pacman" >> /etc/sudoers'

# allow ssh to bind low numbered ports(https://superuser.com/questions/710253/allow-non-root-process-to-bind-to-port-80-and-443)
sudo setcap CAP_NET_BIND_SERVICE=+eip
