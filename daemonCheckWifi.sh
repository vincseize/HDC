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
        sleep 5
        
done  
