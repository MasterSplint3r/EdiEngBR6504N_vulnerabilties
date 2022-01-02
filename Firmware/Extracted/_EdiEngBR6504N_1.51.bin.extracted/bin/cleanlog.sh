#!/bin/sh

#include file
. /var/flash.inc

LOG_FILE=/var/log/security
L2TP_LOG=/var/log/l2tp.err
#SNTP_LOG=/var/log/sntp.log

TMP_LOG=/var/tmp.log
MAX_LINE=1000
SAFE_LINE=900
SLEEP_TIME=1
time=0
time2=0
wpsaction=0
rebootTime=17
#MODE=`cat /web/mode`
. /web/mode
if [ "$MODE" = "-D_sitecom_" ]; then
		rebootTime=10;
elif [ "$MODE" = "-D_topcom_" ]; then

		rebootTime=15;
fi
if [ "$MODEL" = "-D_7264Wn_" ]; then
		rebootTime=10;
fi
while [ true ]; do
	
        sw1=`cat /dev/switch`
        sw2=`cat /dev/switch1`
					if [ "$sw1" = "0" ] ; then
						   time=`expr $time + 1`
					else
								#if [ "$time" = "1" ] || [ "$time" = "2" ] || [ "$time" = "3" ] || [ "$time" = "4" ] || [ "$time" = "5" ]; then
								if [ "$time" -ge "1" ] && [ "$time" -le "5" ]; then
										wpsaction=1
								fi
								time=0
					fi
					if [ "$sw2" = "0" ] ; then
						   time2=`expr $time2 + 1`
						   if [ "$time2" = "120" ]; then
						   			time2=0
						   fi
					else
								#if [ "$time2" = "1" ] || [ "$time2" = "2" ] || [ "$time2" = "3" ] || [ "$time2" = "4" ] || [ "$time2" = "5" ]; then
								if [ "$time2" -ge "1" ] && [ "$time2" -le "5" ]; then
										wpsaction=1
								fi
								time2=0
					fi			
			
					
#	if [ "$sw2" = "0" -a "$wpsaction" = "0" ]; then
#		wpsaction=1
#	fi

        if [ "$time" = "$rebootTime" ] ; then
                echo "led blink 50" > /dev/PowerLED
                echo "Reset to Factory Default!!!"
                /bin/flash default
         if [ "$MODEL" = "-D_topcom_" ]; then
           	/bin/setssidmac.sh
                	
         fi
                sleep 1
                /sbin/reboot
        fi
        if [ "$wpsaction" = "1" ]; then
        	killall wps.sh 2> /dev/null
						/bin/wps.sh 2 0 1 &	
						wpsaction=0
        fi
	if [ -f $LOG_FILE ]; then
		LINES=`cat $LOG_FILE | wc -l`
		if [ "$LINES" -gt "$MAX_LINE" ]; then
			head -n $LINES $LOG_FILE | tail -n $SAFE_LINE > $TMP_LOG
			cp $TMP_LOG $LOG_FILE
			rm -f $TMP_LOG
		fi
	fi

	if [ -f $L2TP_LOG ]; then
		LINES=`cat $L2TP_LOG | wc -l`
		if [ "$LINES" -gt "$MAX_LINE" ]; then
			head -n $LINES $L2TP_LOG | tail -n $SAFE_LINE > $TMP_LOG
			cp $TMP_LOG $L2TP_LOG
			rm -f $TMP_LOG
		fi
	fi

#	if [ -f $SNTP_LOG ]; then
#		LINES=`cat $SNTP_LOG | wc -l`
#		if [ "$LINES" -gt "$MAX_LINE" ]; then
#			head -n $LINES $SNTP_LOG | tail -n $SAFE_LINE > $TMP_LOG
#			cp $TMP_LOG $SNTP_LOG
#			rm -f $TMP_LOG
#		fi
#	fi

	CHECK=0	
	case "$WAN_MODE" in
	"0")
	    connect=`ifconfig eth1 | grep "inet addr"`
    	if [ "$connect" ]; then
			CHECK=1
		fi
		;;
#	"1")
#		CHECK=1
#		;;
	"1" | "2" | "3" | "6")
#	    if [ -f /etc/ppp/link ]; then
			CHECK=1
#		fi
		;;
	esac

	if [ "$CHECK" = "1" ]; then
		DNRD_PID=`ps -aux | grep -v grep | grep dnrd`
       		if [ "$DNRD_PID" = "" ]; then
	        	echo [`date +"%F %T"`]: [DNS]: dns restart ... >> /var/log/security
	        	/bin/dnrd.sh
		fi
	fi

	if [ "$REMANG_ENABLE" = "1" ]; then
		WEBS_STAT=`ps -aux | grep -v grep | grep webs | tr -s " " | cut -d " " -f5`
		WEBS_PID=`ps -aux | grep -v grep | grep webs`
		if [ "$WEBS_STAT" = "R" ] || [ "$WEBS_PID" = "" ]; then
			echo 'WEBS Restarting ! '
			killall webs 2> /dev/null
			sleep 3
			#/bin/webs
			webs&
		fi
	fi

	
	sleep $SLEEP_TIME
done
