#!/bin/sh
#  $1 : INT_IP
#  $2 : EXT_IP

#sleep 1

echo "-----> Virtual Server"

IPTABLES=/bin/iptables

#include file
. /var/flash.inc

WAN1=eth1

if [ "$WAN_MODE" = "2" -o "$WAN_MODE" = "3" -o "$WAN_MODE" = "6" ]; then
  WAN1=ppp0
  WAN2=ppp1
fi

if [ "$VSER_ENABLED" = "0" ]; then
	echo "Virtual Server disable!"
	exit 0
fi

if [ "$VSER_TBL_NUM" -gt "0" ] && [ "$VSER_ENABLED" -gt "0" ];
then
	echo "VSER_NUM=$VSER_TBL_NUM"
	num=1
	while [ "$num" -le "$VSER_TBL_NUM" ];
	do
		#VSER_TBL=`flash get VSER_TBL | grep VSER_TBL$num`
	        eval "port_ip="\$VSER_TBL$num""
		ip=`echo $port_ip | cut -f1 -d,`
		port1=`echo $port_ip | cut -f2 -d,`
		port1=`echo $port1 | cut -f2 -d ' '`
		protocol=`echo $port_ip | cut -f3 -d,`
		port2=`echo $port_ip | cut -f4 -d,`
		port2=`echo $port2 | cut -f2 -d ' '`
		session=`echo $port_ip | cut -f5 -d,`
		
		WAN_ITEM=$WAN1

		if [ "$session" = "1" ]; then
			WAN_ITEM=$WAN2
		fi
	
		eval wanIP=`ifconfig $WAN_ITEM | grep inet | cut -f 2 -d":" | cut -f 1 -d" "`

		num=`expr $num + 1`

		if [ "$wanIP" = "" ]; then
			continue
		fi 
	
		if [ "$protocol" = "1" ]; then
			$IPTABLES -A PREROUTING -t nat -p TCP -d $wanIP --dport $port2 -j DNAT --to $ip:$port1
#			$IPTABLES -A POSTROUTING -t nat -p TCP -d $ip --dport $port1 -j SNAT --to $1
			$IPTABLES -A POSTROUTING -t nat -p TCP -s $IP_ADDR/$SUBNET_MASK -d $ip --dport $port1 -j SNAT --to $1
		fi
		if [ "$protocol" = "2" ]; then
			$IPTABLES -A PREROUTING -t nat -p UDP -d $wanIP -m multiport --dports $port2 -j DNAT --to $ip:$port1
#			$IPTABLES -A POSTROUTING -t nat -p UDP -d $ip -m multiport --dports $port1 -j SNAT --to $1
			$IPTABLES -A POSTROUTING -t nat -p UDP -s $IP_ADDR/$SUBNET_MASK -d $ip -m multiport --dports $port1 -j SNAT --to $1
	    fi
	    if [ "$protocol" = "3" ]; then
			$IPTABLES -A PREROUTING -t nat -p TCP -d $wanIP --dport $port2 -j DNAT --to $ip:$port1
			$IPTABLES -A PREROUTING -t nat -p UDP -d $wanIP -m multiport --dports $port2 -j DNAT --to $ip:$port1
#			$IPTABLES -A POSTROUTING -t nat -p TCP -d $ip --dport $port1 -j SNAT --to $1
#			$IPTABLES -A POSTROUTING -t nat -p UDP -d $ip -m multiport --dports $port1 -j SNAT --to $1
			$IPTABLES -A POSTROUTING -t nat -p TCP -s $IP_ADDR/$SUBNET_MASK -d $ip --dport $port1 -j SNAT --to $1
			$IPTABLES -A POSTROUTING -t nat -p UDP -s $IP_ADDR/$SUBNET_MASK -d $ip -m multiport --dports $port1 -j SNAT --to $1
	    fi

		if [ "$port2" = "1723" ] && [ "$protocol" != "2" ]; then
			$IPTABLES -A PREROUTING -t nat -p 47 -d $wanIP -j DNAT --to $ip
			$IPTABLES -A POSTROUTING -t nat -p 47 -s $IP_ADDR/$SUBNET_MASK -d $ip -j SNAT --to $1
		fi

	done
fi
