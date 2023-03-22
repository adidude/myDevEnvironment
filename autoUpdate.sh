#!/bin/bash
mv /home/$USER/Logs/lastUpdateLog /home/$USER/Logs/lastUpdateLog.old
date > /home/$USER/Logs/lastUpdateLog
pacman -Syu --noconfirm >> /home/$USER/Logs/lastupdateLog
yay