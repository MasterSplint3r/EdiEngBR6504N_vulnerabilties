#!/bin/sh

if [ -f /var/flash.inc ]; then
	echo "don't create flash.inc"
else
	echo "create flash.inc"
	flash all2 > /var/flash.inc
fi
. /var/flash.inc

SNMPD_CONF=/etc/snmpd.conf
TRAP_RECEIVER=$SNMP_NAME
COMMUNITY=public

echo "" > $SNMPD_CONF
echo "syslocation  f" >>  $SNMPD_CONF
echo "sysservices 79" >> $SNMPD_CONF
echo "rwcommunity  $COMMUNITY" >> $SNMPD_CONF
echo "trap2sink  $TRAP_RECEIVER $COMMUNITY" >> $SNMPD_CONF

killall snmpd

if [ "$SNMP_ENABLED" = "1" ]; then
	/bin/snmpd -f -Le -d -c $SNMPD_CONF &
fi
