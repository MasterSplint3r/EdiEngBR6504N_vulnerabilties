#!/bin/sh
#
# script file to start wlan applications (IAPP, Auth, Autoconf) daemon
#
# Usage: wlanapp.sh [start|kill] wlan_interface...br_interface
#
#if [ $# -lt 2 ] || [ $1 != 'start' -a $1 != 'kill' ] ; then 
#	echo "Usage: $0 [start|kill] ra_interface...br_interface [digest] [qfirst]"
#	exit 1 
#fi

. /var/flash.inc

killall rt2860apd 2> /dev/null

echo "------> 802.1x--------->Enter"
ENABLE_1X=0
if [ $WLAN_ENCRYPT -lt 3 ]; then
    if [ "$WLAN_ENABLE_1X" != 0 ] || [ "$MAC_AUTH_ENABLED" != 0 ]; then
        ENABLE_1X=1
    fi
else
    ENABLE_1X=1
fi

if [ "$ENABLE_1X" = '1' ] && [ "$SECURITY_MODE" != '2' ] && [ "$AP_MODE" != '3' ] && [ "$AP_MODE" != '4' ] && [ "$AP_MODE" != '5' ]; then
	
	rt2860apd &
	iwpriv ra0 set SSID=$SSID
fi
echo "------> 802.1x------>Exit"