#!/bin/sh

SEC_LOG=/var/log/security
DHID_STATUS_FILE=/var/dhid_status

STATUS=`cat $DHID_STATUS_FILE`

if [ "$STATUS" != "on" ]; then
	echo [`date +"%F %T"`]: [DDNS]: DHIS online >> $SEC_LOG
	echo "on" > $DHID_STATUS_FILE
fi
	
