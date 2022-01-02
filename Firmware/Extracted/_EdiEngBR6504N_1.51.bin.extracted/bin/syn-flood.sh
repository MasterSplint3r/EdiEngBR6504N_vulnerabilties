#!/bin/sh
#  $1 = 0/1 : disable/enable

#include file
. /var/flash.inc

echo " - Syn-Flood: $1"

iptables -F synflood 2> /dev/null
iptables -X synflood 2> /dev/null

case "$SYN_TIME" in
	"0")
		TIME=sec
		;;
	"1")
		TIME=minute
		;;
	"2")
		TIME=hour
		;;
esac

if [ "$1" = "1" ]; then
	iptables -N synflood
	iptables -A synflood -p tcp --syn -m limit --limit $SYN_PACK/$TIME --limit-burst $SYN_BUR -j RETURN
#	iptables -A synflood -p tcp -j LOG --log-prefix "Sync Flood: "
	iptables -A synflood -p tcp -j REJECT --reject-with tcp-reset
	iptables -A INPUT -p tcp -m state --state NEW -j synflood
fi
