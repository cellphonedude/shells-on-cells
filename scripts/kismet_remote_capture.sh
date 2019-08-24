#!/bin/bash
sudo ifconfig mon0 up
kismet_cap_linux_wifi --connect localhost:3501 --source=mon0:name=Xcape_PTDB --daemonize &