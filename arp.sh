#-------------------------------------------------------#
#------------------ ARP-Notification v1.0 --------------#
#-------------------------------------------------------#
#-------- Johannes Wieland ----- 16.08.2015 ------------#
#-------------------------------------------------------#

while true; do

route -n > /opt/arpWatchNotification/gateway
perl -ne 'while (/([0-9]+\.){3}[0-9]+/g) {print "$&\n"};' /opt/arpWatchNotification/gateway > /opt/arpWatchNotification/gatewayip
echo "Gateway:" $(sed -n 2p /opt/arpWatchNotification/gatewayip)
gw=$(sed -n 2p /opt/arpWatchNotification/gatewayip)

arp -a > /opt/arpWatchNotification/arp_tmp
perl -ne 'while (/([0-9]+\.){3}[0-9]+/g) {print "$&\n"};' /opt/arpWatchNotification/arp_tmp > /opt/arpWatchNotification/ip
perl -ne 'while (/([a-f0-9]+\:){5}[a-f0-9]+/g) {print "$&\n"};' /opt/arpWatchNotification/arp_tmp > /opt/arpWatchNotification/mac

sort /opt/arpWatchNotification/mac  | uniq -D -w 17 > /opt/arpWatchNotification/alert


if [ -s /opt/arpWatchNotification/alert ]; then
	echo "----------------------------"
	echo "Doppelte MAC: " $(sed -n 1p /opt/arpWatchNotification/alert)
	echo "----------------------------"
	echo "Doppelter Mac Eintrag gefunden"
	grep -n  $(sed -n 1p /opt/arpWatchNotification/alert) /opt/arpWatchNotification/mac > /opt/arpWatchNotification/tmp

	cut -c 1-1 /opt/arpWatchNotification/tmp | head > /opt/arpWatchNotification/zeilen

	while read line
	do
		tmp=$(sed -n $line\p /opt/arpWatchNotification/ip)
		if [ $tmp != $gw ];
		then
		        notify-send "ARP-Watch: Doppelter MAC Eintrag gefunden! \n Spoofing über: "$tmp
			echo "Spoofing über: " $tmp >> /opt/arpWatchNotification/LOG.txt
		else 
			echo ""
		fi 
	done < /opt/arpWatchNotification/zeilen


else
	echo "Alles gut! :-)"
        echo "Ausgeführt um "$(date) " " >> /opt/arpWatchNotification/LOG.txt

fi



rm /opt/arpWatchNotification/ip /opt/arpWatchNotification/mac /opt/arpWatchNotification/arp_tmp /opt/arpWatchNotification/gateway /opt/arpWatchNotification/gatewayip  /opt/arpWatchNotification/alert /opt/arpWatchNotification/tmp /opt/arpWatchNotification/zeilen

echo "Warte 60 Sekunden..."
sleep 60;
done
