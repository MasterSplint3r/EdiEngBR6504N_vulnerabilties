#!/bin/sh

TMP_FILE=/var/route.tmp
LOG_FILE=/var/log/route.log

line=0
route -n> $TMP_FILE
line=`cat $TMP_FILE | wc -l`
num=3

set -f

echo Date: `date +"%F %T"` > $LOG_FILE

while [ $num -le $line ];
do
    ROUTE_RULE=` head -n $num $TMP_FILE | tail -n 1`
	
	#echo "rule $num: $ROUTE_RULE"

    HOST_IP=`echo $ROUTE_RULE | cut -f1 -d " "`
    GATEWAY_IP=`echo $ROUTE_RULE | cut -f2 -d " "`

	#echo "HOST_IP: $HOST_IP   GATEWAY_IP: $GATEWAY_IP"

	if [ "$GATEWAY_IP" != "*" ] && [ "$HOST_IP" != "default" ]; then
		echo "delete old route rule-> Host: $HOST_IP Gateway: $GATEWAY_IP" >> $LOG_FILE
		route del -host $HOST_IP gw $GATEWAY_IP
	fi

    num=`expr $num + 1`
done

rm -f $TMP_FILE
