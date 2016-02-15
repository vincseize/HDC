#!/bin/bash
#
# Effectue un PING sur l'adresse IP du routeur. S'il est
# inaccessible, la commande "service network-manager restart"
# est lancée. Cela permet de rétablir la connexion la
# plupart du temps.
# 
# À copier dans /usr/local/bin/
# 
ROUTER_IP=192.168.0.254
( ! ping -c1 $ROUTER_IP >/dev/null 2>&1 ) && service network-manager restart >/dev/null 2>&1

# Ce script doit être ajouté aux tâches CRON avec la ligne
# suivante (lancer "crontab -e" pour l'ajouter) :
#
# */5 * * * * root /usr/local/bin/wificheck.sh
#
# Ceci permettra de lancer ce test toutes les 5 minutes, tous les jours
