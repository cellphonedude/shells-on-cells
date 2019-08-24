#!/bin/bash
sudo apt install raspberrypi-kernel-headers git libgmp3-dev gawk qpdf bison flex make bc -y
sudo wget https://raw.githubusercontent.com/notro/rpi-source/master/rpi-source -O /usr/bin/rpi-source && sudo chmod +x /usr/bin/rpi-source && /usr/bin/rpi-source -q --tag-update
sudo rpi-source
sleep 10
sudo reboot
exit 0
