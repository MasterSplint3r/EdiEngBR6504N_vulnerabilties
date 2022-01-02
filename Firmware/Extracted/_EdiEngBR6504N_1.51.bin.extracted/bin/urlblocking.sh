#!/bin/sh

#sleep 1

echo "-----> URL Blocking"

#include file
. /var/flash.inc
IPTABLES=/bin/iptables

URLB_FILE=/proc/url_blocking_list
CPF_MOD=CPF_mod
URLB_MOD=urlblock_mod

rmmod $CPF_MOD 2> /dev/null
rmmod $URLB_MOD 2> /dev/null
insmod $CPF_MOD

if [ "$FIREWALL_ENABLE" = "0" ]; then
	exit 0
fi

echo "-----> URL blocking"

if [ "$URLB_ENABLED" = "1" ]; then

	echo "URLB_TBL_NUM= $URLB_TBL_NUM"

	i=0

	while [ "$i" != "$URLB_TBL_NUM" -a "$URLB_TBL_NUM" != "0" ]
	do
	    COUNT=`expr $i + 1`
		
	    eval "echo \$URLB_TBL$COUNT > $URLB_FILE"

	    i=`expr $i + 1`
	done

	if [ "$URLB_TBL_NUM" != "0" ]; then
	    insmod $URLB_MOD
	fi
fi
