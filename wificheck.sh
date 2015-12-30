#!/bin/bash
#
# a copier dans /usr/local/bin/

ROUTER_IP=192.168.0.254
( ! ping -c1 $ROUTER_IP >/dev/null 2>&1 ) && service network-manager restart >/dev/null 2>&1
