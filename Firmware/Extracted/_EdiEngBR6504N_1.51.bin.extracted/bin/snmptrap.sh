#/bin/sh

#============ Remove all file first ===============
if [ -e /var/flash.inc ]; then
	. /var/flash.inc
else
	/bin/flash all2 > /var/flash.inc
	. /var/flash.inc
fi

#if [ -e /var/curip ];then
#	. /var/curip
#else
#	/var/curip.sh
#	. /var/curip
#fi

if [ $SNMP_ENABLED = 1 ]; then
	if [ $SNMP_TRAP != 0 ];then
#		if [ $SNMP_NAME != "" ];then
			echo "*************** send snmptrap start ************** "
#			if [ $SNMP_FLAG = 0 ];then
#				snmptrap $SNMP_TRAP 0 $SNMP_MANAGER_IP $SNMP_COMMUNIITY
				snmptrap 1 0 $SNMP_MANAGER_IP public
#			else
#				snmptrap $SNMP_TRAP 1 $SNMP_MANAGER_IP $SNMP_COMMUNITY
#			fi
			echo "*************** send snmptrap end ************** "
#		fi
	fi
fi
