#!/bin/sh
# $1 : WAN interface
# $2 : INT_IP

#sleep 1

echo "-----> Remote Management"

#include file
. /var/flash.inc

iptables -t nat -F remote 2> /dev/null
iptables -t nat -X remote 2> /dev/null

if [ "$REMANG_ENABLE" = "1" ]; then
		
    if [ "$REMAN_PORT" = "0" ]; then
	    REMAN_PORT=80
	fi
							
	iptables -t nat -N remote
	iptables -t nat -A remote -p tcp --dport $REMAN_PORT -j DNAT --to $2:80
	
	if [ "$REMANHOST_ADDR" != "0.0.0.0" ]; then
		iptables -t nat -A PREROUTING -i $1 -p tcp -s $REMANHOST_ADDR --dport $REMAN_PORT -j remote
	else
		iptables -t nat -A PREROUTING -i $1 -p tcp --dport $REMAN_PORT -j remote
	fi
fi

