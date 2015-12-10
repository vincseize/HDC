#!/bin/bash

while true  
        do
	echo $(date)" Check Wifi"
        #echo $(date)
	#iwlist wlan0 scan
	nmcli  -f NAME con status
	#iwlist NEUF_D918 scan # verboten sometimes
	nmcli con list id "NEUF_D918" | awk '/key-mgmt/ {print $2}' # give wpa or other
        sleep 5
done  
