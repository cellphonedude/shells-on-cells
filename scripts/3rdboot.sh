#!/bin/bash
sudo apt install autossh haveged screen ppp bash-completion festival gpsd spectools aircrack-ng dnsmasq hostapd build-essential git pkg-config wireshark tcpdump nmap raspberrypi-kernel-headers gawk qpdf bison flex make bc libncurses5-dev libgmp3-dev -y
sudo wget https://raw.githubusercontent.com/notro/rpi-source/master/rpi-source -O /usr/bin/rpi-source && sudo chmod +x /usr/bin/rpi-source && /usr/bin/rpi-source -q --tag-update
sudo rpi-source
sleep 10
sudo reboot
exit 0
