#!/bin/sh

#include file
if [ -f "/var/flash.inc" ]; then
. /var/flash.inc
fi

echo "ppp$1 dns1=$2 dns2=$3"

ip route add $2 dev ppp$1  proto kernel  scope link  src $4
ip route add $3 dev ppp$1  proto kernel  scope link  src $4
