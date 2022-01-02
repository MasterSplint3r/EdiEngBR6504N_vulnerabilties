#!/bin/sh

#sleep 1

echo "-----> SNTP"

SNTP_LOG=/var/log/sntp.log

#include file
. /var/flash.inc

if [ "$TIMESERVER_ADDR" != "0.0.0.0" ]; then
#	while [ ture ]; do
		echo [`date +"%F %T"`]: [SNTP]: connect to TimeServer $TIMESERVER_ADDR ... >> /var/log/security
		/bin/sntpclock $TIMESERVER_ADDR $TIME_ZONE_SEL > $SNTP_LOG
		if [ $? != 0 ]; then
			echo [`date +"%F %T"`]: [SNTP]: connect fail!! >> /var/log/security
		else
			echo [`date +"%F %T"`]: [SNTP]: connect success! >> /var/log/security
			if [ "$DAYLIGHT_ENABLE" = "1" ]; then
				echo "check Daylight saving..." >> $SNTP_LOG
				MON=`date +%m`
				DAY=`date +%e`
				#pippen 20060420
				if [ "$MON" -gt "$START_MONTH" -a "$MON" -lt "$END_MONTH" -o "$MON" -eq "$START_MONTH" -a "$DAY" -ge "$START_DAY" -o "$MON" -eq "$END_MONTH" -a "$DAY" -le "$END_DAY" ]; then
					TIME=[`date +"%F %T"`]
					echo "$TIME: [SNTP]: It's daylight saving...add one hour" >> $SNTP_LOG
					YEAR=`date +%Y`
					HOUR=`date +%H`
					MINUTE=`date +%M`
					SEC=`date +%S`
					HOUR=`expr $HOUR + 1`
					date $YEAR.$MON.$DAY-$HOUR:$MINUTE:$SEC
				fi
			fi
			echo [`date +"%F %T"`]: [SNTP]: set time to `date +"%F %T"` >> /var/log/security
#			break
		fi
		
#		sleep 5
#	done
fi
