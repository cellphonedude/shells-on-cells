#!/bin/sh
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo rm -v /etc/ssh/ssh_host_*
sudo dpkg-reconfigure openssh-server
sudo systemctl restart ssh
sleep 10
sudo reboot
exit 0
