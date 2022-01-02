#!/bin/sh

GETMIB="flash get"

TMP_FILE=/var/ipfilter

echo "-----> Access Control"

#
# IP Filter
#
eval `$GETMIB ACPC_ENABLED`
eval `$GETMIB IPDENY_ENABLED`
eval `$GETMIB ACPC_TBL_NUM`

if [ "$IPDENY_ENABLED" = "" ]; then
	IPDENY_ENABLED=0;
fi



iptables -A FORWARD -p icmp -j ACCEPT

if [ "$ACPC_ENABLED" = "0" ]; then
	echo "IP Filter disable!"
	iptables -A ip-filter -j ACCEPT
else
	if [ $ACPC_TBL_NUM -gt 0 ] && [ $ACPC_ENABLED -gt 0 ]; then
		$GETMIB ACPC_TBL > $TMP_FILE
	
		line=`cat $TMP_FILE | wc -l`

		num=1

		while [ $num -le $line ];
		do
			ACPC_TMP=`head -n $num  $TMP_FILE | tail -n 1`
		
			ACPC_TMP1=`echo $ACPC_TMP | cut -f2 -d=`
			if [ "$ACPC_TMP1" != "" ]; then
				ACPC_TMP=`echo $ACPC_TMP | cut -f2 -d=`
			fi

			ACPC_IP=`echo $ACPC_TMP | cut -f2 -d'|'`
			ACPC_IP1=`echo $ACPC_IP | cut -f1 -d:`
			ACPC_IP2=`echo $ACPC_IP | cut -f2 -d:`
		
			ACPC_PORT=`echo $ACPC_TMP | cut -f3 -d'|'`

			PORT_TMP=`echo $ACPC_PORT | cut -f2 -d,`
		
			ACPC_PORT1=`echo $ACPC_PORT | cut -f1 -d:`
			ACPC_PORT2=`echo $ACPC_PORT | cut -f2 -d:`
		
			ACPC_PROTO=`echo $ACPC_TMP | cut -f4 -d'|'`

			if [ "$ACPC_PROTO" = "ALL" ]; then
				if [ "$IPDENY_ENABLED" = "1" ]; then
					#iptables -A ip-filter -p TCP -s $ACPC_IP -m multiport --dports $ACPC_PORT -j DROP
					iptables -A ip-filter -p TCP -m iprange --src-range $ACPC_IP1-$ACPC_IP2 -m multiport --dports $ACPC_PORT -j DROP
					#iptables -A ip-filter -p UDP -s $ACPC_IP -m multiport --dports $ACPC_PORT -j DROP
					iptables -A ip-filter -p UDP -m iprange --src-range $ACPC_IP1-$ACPC_IP2 -m multiport --dports $ACPC_PORT -j DROP
				else
					#iptables -A ip-filter -p TCP -s $ACPC_IP -m multiport --dports $ACPC_PORT -j ACCEPT
					 iptables -A ip-filter -p UDP -m iprange --src-range $ACPC_IP1-$ACPC_IP2 -m multiport --dports $ACPC_PORT -j ACCEPT
				fi
			else
				if [ "$IPDENY_ENABLED" = "1" ]; then
					if [ "$ACPC_PORT" = "1863" ]; then
						#iptables -A FORWARD -p TCP -s $ACPC_IP -d 207.46.104.20 -j DROP
						iptables -A FORWARD -p TCP -m iprange --src-range $ACPC_IP1-$ACPC_IP2 -d 207.46.104.20 -j DROP
					fi
					#iptables -A ip-filter -p $ACPC_PROTO -s $ACPC_IP -m multiport --dports $ACPC_PORT -j DROP
					iptables -A ip-filter -p $ACPC_PROTO -m iprange --src-range $ACPC_IP1-$ACPC_IP2 -m multiport --dports $ACPC_PORT -j DROP
				else
					#iptables -A ip-filter -p $ACPC_PROTO -s $ACPC_IP -m multiport --dports $ACPC_PORT -j ACCEPT
					iptables -A ip-filter -p $ACPC_PROTO -m iprange --src-range $ACPC_IP1-$ACPC_IP2 -m multiport --dports $ACPC_PORT -j ACCEPT
				fi
			fi
		
			num=`expr $num + 1`
		done

		rm -f $TMP_FILE
	fi
if [ "$IPDENY_ENABLED" = "1" ]; then
				iptables -D ip-filter -j ACCEPT
				iptables -A ip-filter -j ACCEPT
	else
				iptables -D ip-filter -i br0 -j DROP
				iptables -A ip-filter -i br0 -j DROP
fi
fi

#
# MAC Filter
#
eval `$GETMIB MACFILTER_ENABLED`
eval `$GETMIB MACFILTER_TBL_NUM`
eval `$GETMIB MACDENY_ENABLED`

if [ "$MACDENY_ENABLED" = "" ]; then
	MACDENY_ENABLED=0;
fi

if [ "$MACFILTER_ENABLED" = "0" ]; then
	echo "MAC Filter disable!"
	iptables -A FORWARD -j ip-filter
else
	if [ $MACFILTER_TBL_NUM -gt 0 ] && [ $MACFILTER_ENABLED -gt 0 ];
	then
		num=1
		while [ $num -le $MACFILTER_TBL_NUM ];
		do
	    	MACFILTER_TBL=`flash get MACFILTER_TBL | grep MACFILTER_TBL$num`
			tmp_addr=`echo $MACFILTER_TBL | cut -f2 -d=`
			addr=`echo $tmp_addr | cut -f1 -d,`
			
			if [ "$MACDENY_ENABLED" = "1" ]; then
				iptables -A FORWARD -m mac --mac-source $addr -j DROP
			else
				iptables -A FORWARD -m mac --mac-source $addr -j ip-filter
			fi
			num=`expr $num + 1`
    	done
	fi
	if [ "$MACDENY_ENABLED" = "1" ]; then
		iptables -A FORWARD -j ip-filter
	else
		iptables -D FORWARD -i br0 -j DROP
		iptables -A FORWARD -i br0 -j DROP
	fi
fi

