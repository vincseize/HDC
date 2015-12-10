#!/bin/bash

while true  
        do
	# echo $(date)" Check Wifi"

	echo "######## if wifi connection and give name ################"
	iwconfig 2>&1 | grep ESSID
	#echo "######### all wifi ###########"
	#iwlist wlan0 scan # all wifi
	echo "######################"
	nmcli -f NAME con status # --> NOM : NAME CONNECTION
	#echo "######## scan wifi name if authorized     #############"
	#iwlist NEUF_D918 scan # verboten sometimes
	echo "## Details even not connected ####"
	nmcli con list id "NEUF_D918" | awk '/key-mgmt/ {print $2}' # ---> TYPE WPA



: '
Disconnect:

nmcli d disconnect iface wlan0

Connect:

nmcli d wifi connect <WiFiSSID> password <WiFiPassword> iface wlan0
Just change wlan0, <WiFiSSID>, <WiFiPassword> to reflect your setup.

If WiFi info already saved, easier way:

Disconnect:

nmcli c down id <WiFiConn>

Connect:

nmcli c up id <WiFiConn>
'







        sleep 5
        
        
        
done  
