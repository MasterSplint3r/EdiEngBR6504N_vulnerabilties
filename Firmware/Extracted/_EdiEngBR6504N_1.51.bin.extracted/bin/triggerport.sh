#!/bin/sh
#  $1 : INT_IP
#  $2 : EXT_IP
#sleep 1

echo "-----> Special Application"
#include file
. /var/flash.inc

if [ "$TRIGGERPORT_ENABLED" = "0" ]; then
	echo "TriggerPort disable!"
	exit 0
fi


if [ "$TRIGGERPORT_ENABLED" = "1" ] ; then
	i=0
	while [ "$i" != "$TRIGGERPORT_TBL_NUM" -a "$TRIGGERPORT_TBL_NUM" != "0" ]
	do
		i=`expr $i + 1`
   #TRIGGERPORT_TBL=`flash get TRIGGERPORT_TBL | grep TRIGGERPORT_TBL$i`

			eval "port_ip="\$TRIGGERPORT_TBL$i""
		ip=`echo $port_ip | cut -f1 -d@ | cut -f2 -d=`
		tcpopen=`echo $port_ip | cut -f2 -d@`
		protocol1=`echo $port_ip | cut -f3 -d@`
		updopen=`echo $port_ip | cut -f4 -d@`
		protocol2=`echo $port_ip | cut -f5 -d@`


		

if [ "$tcpopen" != "" ]; then
#tcpopen=${tcpopen//-/:}
 iptables -A PREROUTING -t nat -p TCP -m multiport --dports $tcpopen -d $2 -j DNAT --to $ip
 iptables -A POSTROUTING -t nat -p TCP -s $IP_ADDR/$SUBNET_MASK -m multiport --dports $tcpopen -d $ip -j SNAT --to $1
fi	   
if [ "$updopen" != "" ]; then
#updopen=${updopen//-/:}
 iptables -A PREROUTING -t nat -p UDP -m multiport --dports $updopen -d $2 -j DNAT --to $ip
 iptables -A POSTROUTING -t nat -p UDP -s $IP_ADDR/$SUBNET_MASK -m multiport --dports $updopen -d $ip -j SNAT --to $1 	
fi	   
    
	done
fi
