#!/bin/bash
# TODO: Figure out how to only use 80% max battery
# TODO: Before running enable flatpak & AURs
pacman -Syu --noconfirm
pacman -S --needed --noconfirm base-devel
sed -i "/MAKEFLAGS=\"-j2\"/c\MAKEFLAGS=\"-j$(nproc)\"" /etc/makepkg.conf
pacman -S --noconfirm ncspot thunderbird code docker
mkdir home/$USER/Utility
mkdir home/$USER/Logs
cd /home/$USER/Utility
git clone https://aur.archlinux.org/yay.git
cd ./yay
makepkg -si --noconfirm
yay -S --noconfirm insomnia-bin nordvpn-bin
gpasswd -a $USER nordvpn
flatpak install -y flathub com.github.tchx84.Flatseal com.discordapp.Discord
systemctl start docker.service
systemctl enable docker.service
systemctl enable --now nordvpnd
# reboot