#!/bin/sh

SEC_LOG=/var/log/security
DHID_STATUS_FILE=/var/dhid_status

STATUS=`cat $DHID_STATUS_FILE`

if [ "$STATUS" != "off" ]; then
	echo [`date +"%F %T"`]: [DDNS]: DHIS offline >> $SEC_LOG
	echo "off" > $DHID_STATUS_FILE
fi
	
