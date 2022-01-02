#!/bin/sh
#  $1 = 0/1 : disable/enable
#  $2       : interface

echo " - DisPing: $1"

if [ "$1" != "0" ]; then
	iptables -A INPUT -i $2 -p icmp -j DROP
else
	iptables -D INPUT -i $2 -p icmp -j DROP > /dev/null 2>&1
fi
