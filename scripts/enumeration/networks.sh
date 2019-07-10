#!/bin/bash
# Node Scan Script
# Enumerate SSID's
_MYIP=$(hostname -I)


echo "Scan Run On $(date) from @ $(hostname)"
echo "-------------------------------------------"
sudo iwlist wlan$1 scan
