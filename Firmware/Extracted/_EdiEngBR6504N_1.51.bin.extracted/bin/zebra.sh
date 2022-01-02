#!/bin/sh
if [ -f /var/flash.inc ]; then
	echo "don't create flash.inc"
else
	echo "create flash.inc"
	flash all2 > /var/flash.inc
fi
. /var/flash.inc

WAN=eth1
LAN=br0
ZEBRA_CONF=/etc/zebra.conf

#kill ripd dameon
kill `cat /var/run/zebra.pid 2>/dev/null` 2>/dev/null

if [ "$RIP_ENABLED" = "0" ] ; then
  exit
fi

# if wireless ISP mode , set WAN to wlan0-vxd
if [ "$OP_MODE" = '1' ];then
	#WAN=wlan$WISP_WAN_ID-vxd
	WAN=br1
fi

#PPoE
if [ "$WAN_MODE" = "2" ]; then
	WAN=ppp0
fi

#PPtP
if [ "$WAN_MODE" = "3" ]; then
	WAN=ppp0
fi

#L2TP
if [ "$WAN_MODE" = "6" ]; then
	WAN=ppp0
fi

echo '' >  $ZEBRA_CONF
echo "hostname Router" >> $ZEBRA_CONF
echo "interface $WAN" >> $ZEBRA_CONF
echo "multicast" >> $ZEBRA_CONF
echo "interface $LAN" >> $ZEBRA_CONF
echo "multicast" >> $ZEBRA_CONF
echo "password @zebra" >> $ZEBRA_CONF

if [ "$RIP_ENABLED" = "1" ]; then
	#start ripd dameon
	 zebra -f $ZEBRA_CONF -d
fi

