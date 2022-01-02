#!/bin/sh

LOCKFILE=/etc/ppp/lockconn

#include file
. /var/flash.inc

RESOLV=/etc/ppp/resolv.conf
if [ "$DNS_MODE" != "1" ]; then
  if [ -r "$RESOLV" ] ; then
    PIDFILE=/var/run/dnrd.pid
    if [ -f $PIDFILE ]; then
      PID=`cat $PIDFILE`
      kill -9 $PID 2> /dev/null
      rm -f $PIDFILE 2> /dev/null
    fi
    name_ip=`grep nameserver $RESOLV | cut -f2 -d " "`
#    route add -net 220.210.194.0 netmask 255.255.255.0 dev ppp1
    /bin/dnrd -s $name_ip
  fi
fi

#used for multiple pppoe in Japan
PPP1IP=`ifconfig ppp1 | grep "inet addr" | cut -f 2 -d":" | cut -f 1 -d" "`
IP1=`echo $PPP1IP | cut -f 1 -d"."`
IP2=`echo $PPP1IP | cut -f 2 -d"."`

if [ "$PPP1IP" != "" ]; then
	route add -net $IP1.$IP2.0.0 netmask 255.255.0.0 dev ppp1
#	route add -net 220.210.0.0 netmask 255.255.0.0 dev ppp1
	route add -net 220.210.194.0   netmask 255.255.255.128 dev ppp1
	route add -net 220.210.195.0   netmask 255.255.255.192 dev ppp1
	route add -net 220.210.195.64  netmask 255.255.255.192 dev ppp1
	route add -net 220.210.197.128 netmask 255.255.255.128 dev ppp1
	route add -net 220.210.198.0   netmask 255.255.255.192 dev ppp1
	route add -net 220.210.198.128 netmask 255.255.255.192 dev ppp1
	route add -net 220.210.199.0   netmask 255.255.255.224 dev ppp1
	route add -net 220.210.199.128 netmask 255.255.255.240 dev ppp1
	route add -net 220.210.199.160 netmask 255.255.255.240 dev ppp1
	route add -net 220.210.199.208 netmask 255.255.255.248 dev ppp1
fi

rm -f $LOCKFILE
