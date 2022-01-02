#!/bin/sh

echo "-----> DDNS"

#include file
. /var/flash.inc

if [ "$DDNS_ENABLED" != "1" ] ; then
	echo "DDNS not ENABLE"         
	exit 0
fi                                                                 
				
DDNS_CONFFILE=/var/ddns.conf
DDNS_BIN=/bin/ez-ipupdate

DHIS_CONFFILE=/var/dhid.conf
DHIS_BIN=/bin/dhid

WAN=br0
case "$WAN_MODE" in
	"0")
		WAN=eth1
		;;
	"1")
		WAN=eth1
		;;
	"2")
		WAN=ppp0
		;;
	"3")
		WAN=ppp0
		;;
	"6")
		WAN=ppp0
		;;
esac

WAN_IP0=`ifconfig $WAN | grep -i "addr:"`
WAN_IP1=`echo $WAN_IP0 | cut -f2 -d:`
WAN_IP=`echo $WAN_IP1 | cut -f1 -d " "`

killall dhid 2> /dev/null

if [ "$DDNS_PVID_SEL" = "dhis" ] || [ "$DDNS_PVID_SEL" = "aiaimamor" ]; then
	
	echo "create $DHIS_CONFFILE..."
	rm -f $DHIS_CONFFILE 2> /dev/null
	echo "{" > $DHIS_CONFFILE
	echo "HostID $DHIS_HOSTID" >> $DHIS_CONFFILE
	if [ "$DHIS_SELECT" = "0" ]; then
		echo "HostPass $DHIS_PASSWORD" >> $DHIS_CONFFILE
	else
		echo "AuthP $DHIS_AUTH_P1" >> $DHIS_CONFFILE
		echo "AuthP $DHIS_AUTH_P2" >> $DHIS_CONFFILE
		echo "AuthQ $DHIS_AUTH_Q1" >> $DHIS_CONFFILE
		echo "AuthQ $DHIS_AUTH_Q2" >> $DHIS_CONFFILE
	fi
	echo "ISAddr $DHIS_ISADDR" >> $DHIS_CONFFILE
	echo "OnCmd /bin/dhid-online.sh" >> $DHIS_CONFFILE
	echo "OffCmd /bin/dhid-offline.sh" >> $DHIS_CONFFILE
	echo "}" >> $DHIS_CONFFILE
	echo "run $DHIS_BIN..."
	$DHIS_BIN
else
	echo "create $DDNS_CONFFILE..."

	rm -f $DDNS_CONFFILE 2> /dev/null

	echo "service-type=$DDNS_PVID_SEL" > $DDNS_CONFFILE
	echo "user=$DDNS_ACCOUNT:$DDNS_PASS" >> $DDNS_CONFFILE
	echo "host=$DDNS_NAME" >> $DDNS_CONFFILE

	# we no support Lance 2003.07.18
	#if[ "$DDNS_MX_NAME" != "" ] ; then
	#	echo "mx=$DDNS_MX_NAME" >> $DDNS_CONFFILE
	#fi
	#if [ "$DDNS_WILDCARD" != "disable" ] ; then
	#	echo "wildcard" >> $DDNS_CONFFILE
	#fi

	echo "run $DDNS_BIN..."
	$DDNS_BIN -c $DDNS_CONFFILE -a $WAN_IP
fi
