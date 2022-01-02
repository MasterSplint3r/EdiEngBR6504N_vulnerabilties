#!/bin/sh
# $1 : interface

#sleep 1

POD_SCRIPT=pod.sh
PING_SCRIPT=disping.sh
SCAN_SCRIPT=portscan.sh
SYN_SCRIPT=syn-flood.sh

echo "-----> intrusion"

if [ "$1" != "" ]; then
    INTERFACE=$1
else
    INTERFACE=eth1
fi

#include file
. /var/flash.inc

# Ping of Death
$POD_SCRIPT $POD_ENABLED

# Discard Ping from WAN
$PING_SCRIPT $PING_ENABLED $INTERFACE

# PortScan
$SCAN_SCRIPT $SCAN_ENABLED $INTERFACE

# Sync flood
$SYN_SCRIPT $SYN_ENABLED

