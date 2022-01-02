#!/bin/sh

LOG_FILE=/var/log/syslog
#SEC_FILE=/var/log/security
PRESS=`cat /dev/switch2`
#include file
. /var/flash.inc
#AP Mode

if [ "$#" = "1" ] ; then
	if [ "$1" = "clean" ]; then
		killall syslogd 2> /dev/null
		rm -f $LOG_FILE 2> /dev/null
		syslogd C
	fi
fi

logread > $LOG_FILE

#logread S >> $SEC_FILE

#syslogd c

