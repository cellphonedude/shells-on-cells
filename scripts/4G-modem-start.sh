#!/bin/sh
sudo qmicli -d /dev/cdc-wdm0 --dms-set-operating-mode='online'
sudo ip link set wwan0 down
echo 'Y' | sudo tee /sys/class/net/wwan0/qmi/raw_ip
sudo ip link set wwan0 up
sleep 2
sudo qmicli -p -d /dev/cdc-wdm0 --device-open-net='net-raw-ip|net-no-qos-header' --wds-start-network="apn='h2g2',ip-type=4" --client-no-release-cid
sleep 1
sudo udhcpc -i wwan0
