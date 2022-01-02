#!/bin/sh

if [ $# -lt 1 ]; then echo "Usage: $0 interface";  exit 1 ; fi

CONF_FILE=/var/udhcpd.conf
LEASE_FILE=/var/lib/misc/udhcpd.leases

#include file
. /var/flash.inc

# See if DHCP server is on

if [ "$DHCP" != '2' ]; then
	exit 0
fi

echo "interface $1" > $CONF_FILE
echo "start $DHCP_CLIENT_START" >> $CONF_FILE
echo "end $DHCP_CLIENT_END" >> $CONF_FILE
echo "opt subnet $SUBNET_MASK" >> $CONF_FILE
echo "opt router $IP_ADDR"  >> $CONF_FILE

if [ "$DNS_MODE" = '0' ]; then
	echo "opt dns $IP_ADDR" >> $CONF_FILE
else
	if [ "$DNS1" != "0.0.0.0" ]; then
		echo "opt dns $DNS1" >> $CONF_FILE
	fi
	if [ "$DNS2" != "0.0.0.0" ]; then
		echo "opt dns $DNS2" >> $CONF_FILE
	fi
	if [ "$DNS3" != "0.0.0.0" ]; then
		echo "opt dns $DNS3" >> $CONF_FILE
	fi
fi

if [ "$DOMAIN_NAME" ]; then
	echo "option domain $DOMAIN_NAME" >> $CONF_FILE
fi

echo "option lease $LAN_LEASE_TIME" >> $CONF_FILE

# Static DHCP Leases
if [ "$SDHCP_ENABLED" = "0" ]; then
	echo "Static DHCP Leases disable!"
	#exit 0
fi

if [ "$SDHCP_TBL_NUM" -gt "0" ] && [ "$SDHCP_ENABLED" -gt "0" ]; then
	echo "SDHCP_NUM=$SDHCP_TBL_NUM"
	num=1
	while [ "$num" -le "$SDHCP_TBL_NUM" ];
	do
	    eval "static_lease="\$SDHCP_TBL$num""
		sdhcp_mac=`echo $static_lease | cut -f1 -d,`
		sdhcp_ip=`echo $static_lease | cut -f2 -d,`

		echo "static_lease $sdhcp_mac $sdhcp_ip" >> $CONF_FILE

		num=`expr $num + 1`
	done
fi

# Static leases map
#echo "static_lease 00:C0:CA:34:20:67 192.168.2.155" >> $CONF_FILE
#static_lease 00:60:08:11:CE:4E 192.168.0.54
#static_lease 00:60:08:11:CE:3E 192.168.0.44

# Delete DHCP server process
PIDFILE=/etc/udhcpc/udhcpc-$BR_INTERFACE.pid

if [ -f $PIDFILE ] ; then
	PID=`cat $PIDFILE`
	if [ "$PID" != "0" ]; then
		kill -9 $PID 2> /dev/null
   	fi
	rm -f $PIDFILE 2> /dev/null
fi

if [ -f "$LEASE_FILE" ]; then
	rm -f $LEASE_FILE 2> /dev/null
fi

echo "" > $LEASE_FILE

fixedip.sh $1 $IP_ADDR $SUBNET_MASK 0.0.0.0

udhcpd $CONF_FILE

