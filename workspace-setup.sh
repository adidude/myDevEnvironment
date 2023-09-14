#!/bin/bash
# TODO: Before running enable flatpak & AURs
echo "(1/11) UPDATING..."
sudo pacman -Syu --noconfirm

echo "(2/11) Setting up battery alarm..."
sed -i "s/user/$USER" ./batteryAlarm.service
cp ./batteryAlarm.service /home/$USER/.config/systemd/user/batteryAlarm.service
cp ./batteryAlarm.timer /home/$USER/.config/systemd/user/batteryAlarm.timer
systemctl --user enable batteryAlarm.timer

echo "(3/11) Getting compilation dependencies..."
sudo pacman -S --needed --noconfirm base-devel

echo "(4/11) Enabling multi-threading on compiling..."
sudo sed -i "/MAKEFLAGS=\"-j2\"/c\MAKEFLAGS=\"-j$(nproc)\"" /etc/makepkg.conf

echo "(5/11) Installing various favourite applications..."
sudo pacman -S --noconfirm thunderbird code docker

echo "(6/11) Installing yay..."
mkdir /home/$USER/Utility
cd /home/$USER/Utility
git clone https://aur.archlinux.org/yay.git
cd ./yay
makepkg -si --noconfirm

echo "(7/11) Installing favourite aur packages..."
yay -S --noconfirm insomnia-bin nordvpn-bin google-chrome

echo "(8/11) Adding user to nordvpn group..."
CURRUSER=$USER
sudo gpasswd -a $CURRUSER nordvpn

echo "(9/11) Installing flatseal and discord..."
sudo flatpak install -y flathub com.github.tchx84.Flatseal com.discordapp.Discord

echo "(10/11) Starting docker service..."
sudo systemctl start docker.service
sudo systemctl enable docker.service

echo "(11/11) Starting up nordvpn service..."
sudo systemctl enable --now nordvpnd
sudo reboot