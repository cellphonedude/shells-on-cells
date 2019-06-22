#!/bin/bash
wget -O - https://www.kismetwireless.net/repos/kismet-release.gpg.key | sudo apt-key add -
echo 'deb https://www.kismetwireless.net/repos/apt/release/stretch stretch main' | sudo tee /etc/apt/sources.list.d/kismet.list
sudo apt update
sudo apt install kismet -y
sudo usermod -a -G kismet pi
sleep 10
sudo reboot
exit 0
