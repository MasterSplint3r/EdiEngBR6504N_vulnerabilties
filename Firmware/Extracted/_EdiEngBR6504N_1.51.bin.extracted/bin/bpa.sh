#!/bin/sh

OPTIONS=/var/bigbond.conf

#include file
. /var/flash.inc

echo "username $TELBP_USER_NAME" > $OPTIONS
echo "password $TELBP_PASSWORD" >> $OPTIONS
if [ $TELBP_ENABLED = 1 ]; then
	echo "authserver $TELBP_IP_ADDR" >> $OPTIONS
else
	echo "authserver sm-server" >> $OPTIONS
fi
#echo "authdomain " >> $OPTIONS
#echo "localaddress " >> $OPTIONS
#echo "localport 5050" >> $OPTIONS

#eval `bpalogin -c $OPTIONS`
bpalogin -c $OPTIONS
