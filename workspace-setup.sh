#!/bin/bash
# TODO: Before running enable flatpak & AURs
cp ./batteryAlarm.service /home/$USER/.config/systemd/user/batteryAlarm.service
cp ./batteryAlarm.timer /home/$USER/.config/systemd/user/batteryAlarm.timer
sudo pacman -Syu --noconfirm
systemctl --user enable batteryAlarm.timer
sudo pacman -S --needed --noconfirm base-devel
sudo sed -i "/MAKEFLAGS=\"-j2\"/c\MAKEFLAGS=\"-j$(nproc)\"" /etc/makepkg.conf
sudo pacman -S --noconfirm ncspot thunderbird code docker
mkdir /home/$USER/Utility
mkdir /home/$USER/Logs
cd /home/$USER/Utility
git clone https://aur.archlinux.org/yay.git
cd ./yay
makepkg -si --noconfirm
yay -S --noconfirm insomnia-bin nordvpn-bin
CURRUSER=$USER
sudo gpasswd -a $CURRUSER nordvpn
sudo flatpak install -y flathub com.github.tchx84.Flatseal com.discordapp.Discord
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo systemctl enable --now nordvpnd
sudo reboot