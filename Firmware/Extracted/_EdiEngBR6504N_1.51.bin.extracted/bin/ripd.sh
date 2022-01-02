#!/bin/sh
. /var/flash.inc  

WAN=eth1
LAN=br0
RIPD_CONF=/etc/ripd.conf

#kill ripd dameon
kill `cat /var/run/ripd.pid 2>/dev/null` 2>/dev/null

if [ "$RIP_ENABLED" = "1" ]; then


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

echo '' >  $RIPD_CONF

echo "hostname ripd" >> $RIPD_CONF
echo "interface $WAN " >> $RIPD_CONF
echo "ip rip send version 1 2 " >> $RIPD_CONF
echo "ip rip receive version 1 2 " >> $RIPD_CONF
#echo "ip rip authentication mode text " >> $RIPD_CONF
#echo "ip rip authentication string zebra " >> $RIPD_CONF
echo "interface $LAN " >> $RIPD_CONF
echo "ip rip send version 1 2 " >> $RIPD_CONF
echo "ip rip receive version 1 2 " >> $RIPD_CONF
#echo "ip rip authentication mode text " >> $RIPD_CONF
#echo "ip rip authentication string zebra " >> $RIPD_CONF
echo "router rip " >> $RIPD_CONF
#echo "timers basic 30 180 120 " >> $RIPD_CONF
echo "network $WAN " >> $RIPD_CONF
echo "passive-interface $WAN " >> $RIPD_CONF
echo "network $LAN" >> $RIPD_CONF
echo "no passive-interface $LAN" >> $RIPD_CONF
 

#start ripd dameon
  
  ripd -f $RIPD_CONF -d
 fi
