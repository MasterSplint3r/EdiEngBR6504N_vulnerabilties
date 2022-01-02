#!/bin/sh
#  $1 = 0/1 : disable/enable

#include file
. /var/flash.inc

echo " - POD: $1"

iptables -F bad-ping 2> /dev/null
iptables -X bad-ping 2> /dev/null

case "$POD_TIME" in
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
	iptables -N bad-ping
	iptables -A bad-ping -p icmp --icmp-type echo-request -m limit --limit $POD_PACK/$TIME --limit-burst $POD_BUR -j RETURN
#每十秒鐘記錄一個 POD 的訊息	
#	iptables -A bad-ping -p icmp --icmp-type echo-request -m recent --name bad-ping --update --seconds 2 -j REJECT 
#	iptables -A bad-ping -p icmp --icmp-type echo-request -j LOG --log-prefix "PingOfDeath Attack: " 
#	iptables -A bad-ping -p icmp --icmp-type echo-request -m recent --name bad-ping --set -j REJECT 
	iptables -A bad-ping -p icmp -j REJECT
	iptables -I INPUT -p icmp --icmp-type echo-request -m state --state NEW -j bad-ping
fi
