# ARP-Watch-Notification
Little Script to notification an ARP Spoofing attack


Test:
Linux Mint with WindowManager i3
Ubuntu 14.04
Linux Mint

TO DO
-----

1.) mkdir /opt/arpWatchNotification

2.) copy the arp.sh to this Directory

3.) chmod 777 /opt/arpWatchNotification/arp.sh

4.) Add Line in /etc/crontab 

@reboot root sh /opt/arpWatchNotification/arp.sh

##########
## INFO ##
##########

For Linux Mint with i3 Window Manager:
Install the Package dunst

sudo apt-get install dunst

add the this Lines to /etc/crontab

DISPLAY=:0.0

XAUTHORITY=/home/benutzer/.Xauthority

