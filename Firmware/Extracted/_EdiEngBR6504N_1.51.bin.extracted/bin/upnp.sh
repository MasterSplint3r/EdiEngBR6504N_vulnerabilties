#!/bin/sh
#

#/bin/create_flash.sh

. /var/flash.inc
echo "-----> UPNP"

# clean old
line=0
ps -A | grep upnpd > /var/tmpfile 
line=`cat /var/tmpfile | wc -l`
num=1
while [ $num -le $line ];
do
	pat0=` head -n $num /var/tmpfile | tail -n 1`
	pat1=`echo $pat0 | cut -f2 -dS`
	pat2=`echo $pat1 | cut -f1 -d " "`
	if [ "$pat2" = 'upnpd' ]; then
		pat1=`echo $pat0 | cut -f1 -dS`
		pat2=`echo $pat1 | cut -f1 -d " "`
		kill -9 $pat2
	fi
	num=`expr $num + 1`
done

if [ "$1" = "disable" ]; then
	UPNP_ENABLE=0
fi

if [ "$UPNP_ENABLE" = "0" ]; then
	echo "UPNP disabled!"
	route del -net 239.0.0.0 netmask 255.0.0.0 br0
else
# -----joseph , Oct 18,2005--------
# cp -a /etc/linuxigd  /var

 #----------------------------------

	WAN=eth1

# if wireless ISP mode , set WAN to ra0
	if [ "$OP_MODE" = "1" ]; then
		WAN=ra$WISP_WAN_ID
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

	INT_IP0=`ifconfig $BRIDGE | grep -i "addr:"`
	INT_IP1=`echo $INT_IP0 | cut -f2 -d:`
	INT_IP=`echo $INT_IP1 | cut -f1 -d " "`

	cp -f /etc/linuxigd/gatedesc.xml.def /etc/linuxigd/gatedesc.xml		
	echo "<presentationURL>http://$INT_IP/</presentationURL>" >> /etc/linuxigd/gatedesc.xml
	echo "</device>" >> /etc/linuxigd/gatedesc.xml
	echo "</root>" >> /etc/linuxigd/gatedesc.xml

	WDS_LIST=`ifconfig | grep -i wds | cut -b -4`
	APCLI_LIST=`ifconfig | grep -i apcli | cut -b -6`
	route add -net 239.0.0.0 netmask 255.0.0.0 br0
	ifconfig eth0 down
	ifconfig ra0 down
	
	upnpd $WAN br0 &
		
	ifconfig eth0 up
	ifconfig ra0 up
	sleep 3
#2008/01/24 Kyle add.
#fixed upnp up cause wds connection fail issue. 
	for ARG in $WDS_LIST ; do
		ifconfig $ARG up
		brctl addif br0 $ARG
	done
#fixed upnp up cause apcli connection fail issue. 
	for ARG in $APCLI_LIST ; do
		ifconfig $ARG up
		brctl addif br0 $ARG
	done	
fi
