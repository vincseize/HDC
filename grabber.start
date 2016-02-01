#!/bin/bash
#
# Demarre une instance du logiciel "Grabber" quand la passerelle reseau est accessible,
# et le relance si jamais il plante.
# En revanche si il quitte de façon normale (exit code 0), il ne se relance pas.
#
# LRDS 2016 - Karlova & Polosson
#

if [ ! -e "/root/disableLogs" ]; then
	logfile="/root/grabber_start.log"
else
	logfile="/dev/null"
fi
# logfile="/dev/null"	## Decommenter pour forcer la desactivation du fichier de log

echo -e "LRDS GRABBER STARTUP LAUNCHER - $(date)\n" >$logfile

ROUTER_IP=""
while [[ ! $ROUTER_IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
do
	ROUTER_IP=`route -n | grep "UG" | grep -v "UGH" | cut -f 10 -d " "`
	sleep 1
done

echo -e "Gateway IP: $ROUTER_IP\n" >>$logfile

while ! ping -w1 -c1 $ROUTER_IP >>$logfile 2>&1
do
   echo -e "\nNetwork gateway UNREACHABLE!! Retrying..." >>$logfile
   sleep 1
done

echo -e "\nOK! Network gateway now reachable. Launching Grabber..." >>$logfile

if [ ! -e "/opt/dynamixyz/grabber/BuildL/Grabber" ]; then
	echo -e "\n!!!!!!! Grabber binary NOT FOUND ('/opt/dynamixyz/grabber/BuildL/Grabber' doesn't exists) !!!!!!!" >>$logfile
	exit 0
fi

countCrash=0

until /opt/dynamixyz/grabber/BuildL/Grabber
do
	exitcode=$?
	((countCrash = $countCrash + 1))
    echo -e "\n################\n'Grabber' was interrupted with exit code $exitcode. Respawning...\n################" >&2
    echo -e "\n################\n'Grabber' was interrupted with exit code $exitcode, on $(date). (crash #$countCrash)." >>$logfile
    sleep 2
done
