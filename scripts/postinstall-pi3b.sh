#!/bin/bash
sudo apt-mark hold raspberrypi-kernel raspberrypi-bootloader
apt update && apt upgrade -y
cd /home/pi/
git clone https://github.com/seemoo-lab/nexmon.git
cd /home/pi/nexmon
cd /home/pi/nexmon/buildtools/isl-0.10
./configure
make -j4
make install
ln -s /usr/local/lib/libisl.so /usr/lib/arm-linux-gnueabihf/libisl.so.10
ifconfig wlan0 down
cd /home/pi/nexmon
source setup_env.sh
make -j4
cd /home/pi/nexmon/patches/bcm43430a1/7_45_41_46/nexmon/
make -j4
make backup-firmware
make install-firmware
cd /home/pi/nexmon/utilities/nexutil/
make -j4 && make install
mv /lib/modules/4.14.98-v7+/kernel/drivers/net/wireless/broadcom/brcm80211/brcmfmac/brcmfmac.ko /lib/modules/4.14.98-v7+/kernel/drivers/net/wireless/broadcom/brcm80211/brcmfmac/brcmfmac.ko.orig
cp /home/pi/nexmon/patches/bcm43430a1/7_45_41_46/nexmon/brcmfmac_4.14.y-nexmon/brcmfmac.ko /lib/modules/4.14.98-v7+/kernel/drivers/net/wireless/broadcom/brcm80211/brcmfmac/
depmod -a
sleep 10
reboot
exit 0
