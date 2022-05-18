#!/bin/bash
sudo apt update --fix-missing
sudo apt upgrade
sudo apt autoremove
date > /home/adi/lastupdate