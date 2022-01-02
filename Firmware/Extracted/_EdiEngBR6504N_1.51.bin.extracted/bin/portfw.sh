#!/bin/sh
#  $1 : INT_IP
#  $2 : EXT_IP

#sleep 1

echo "-----> Port Forwarding"

#include file
. /var/flash.inc

WAN1=eth1

if [ "$WAN_MODE" = "2" -o "$WAN_MODE" = "3" -o "$WAN_MODE" = "6" ]; then
  WAN1=ppp0
  WAN2=ppp1
fi

if [ "$PORTFW_ENABLED" = "0" ]; then
	echo "PortForwarding disable!"
	exit 0
fi

if [ $PORTFW_TBL_NUM -gt 0 ] && [ $PORTFW_ENABLED -gt 0 ];
then
	echo "PORTFW_NUM=$PORTFW_TBL_NUM"
	num=1
	while [ $num -le $PORTFW_TBL_NUM ];
	do
#		PORTFW_TBL=`flash get PORTFW_TBL | grep PORTFW_TBL$num`
	    eval "port_ip="\$PORTFW_TBL$num""
		ip=`echo $port_ip | cut -f1 -d,`
		port1=`echo $port_ip | cut -f2 -d,`
		tmp_port=`echo $port_ip | cut -f3 -d,`
		port2=`echo $tmp_port | cut -f2 -d ' '`
		protocol=`echo $port_ip | cut -f4 -d,`
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
			if [ "$port1" = "$port2" ]; then
				iptables -A PREROUTING -t nat -p TCP --dport $port1 -d $wanIP -j DNAT --to $ip
#				iptables -A POSTROUTING -t nat -p TCP --dport $port1 -d $ip -j SNAT --to $1
				iptables -A POSTROUTING -t nat -p TCP -s $IP_ADDR/$SUBNET_MASK --dport $port1 -d $ip -j SNAT --to $1
			else
				iptables -A PREROUTING -t nat -p TCP -m multiport --dports $port1:$port2 -d $wanIP -j DNAT --to $ip
#				iptables -A POSTROUTING -t nat -p TCP -m multiport --dports $port1:$port2 -d $ip -j SNAT --to $1
				iptables -A POSTROUTING -t nat -p TCP -s $IP_ADDR/$SUBNET_MASK -m multiport --dports $port1:$port2 -d $ip -j SNAT --to $1
			fi
		fi
		if [ "$protocol" = "2" ]; then
			if [ "$port1" = "$port2" ]; then
				iptables -A PREROUTING -t nat -p UDP -m multiport --dports $port1 -d $wanIP -j DNAT --to $ip
#				iptables -A POSTROUTING -t nat -p UDP -m multiport --dports $port1 -d $ip -j SNAT --to $1
				iptables -A POSTROUTING -t nat -p UDP -s $IP_ADDR/$SUBNET_MASK -m multiport --dports $port1 -d $ip -j SNAT --to $1
			else
				iptables -A PREROUTING -t nat -p UDP -m multiport --dports $port1:$port2 -d $wanIP -j DNAT --to $ip
#				iptables -A POSTROUTING -t nat -p UDP -m multiport --dports $port1:$port2 -d $ip  -j SNAT --to $1
				iptables -A POSTROUTING -t nat -p UDP -s $IP_ADDR/$SUBNET_MASK -m multiport --dports $port1:$port2 -d $ip  -j SNAT --to $1
			fi
	    fi
	    if [ "$protocol" = "3" ]; then
			if [ "$port1" = "$port2" ]; then
				iptables -A PREROUTING -t nat -p TCP --dport $port1 -d $wanIP -j DNAT --to $ip
				iptables -A PREROUTING -t nat -p UDP -m multiport --dports $port1 -d $wanIP -j DNAT --to $ip
#				iptables -A POSTROUTING -t nat -p TCP --dport $port1 -d $ip -j SNAT --to $1
#				iptables -A POSTROUTING -t nat -p UDP -m multiport --dports $port1 -d $ip -j SNAT --to $1
				iptables -A POSTROUTING -t nat -p TCP -s $IP_ADDR/$SUBNET_MASK --dport $port1 -d $ip -j SNAT --to $1
				iptables -A POSTROUTING -t nat -p UDP -s $IP_ADDR/$SUBNET_MASK -m multiport --dports $port1 -d $ip -j SNAT --to $1
			else
				iptables -A PREROUTING -t nat -p TCP -m multiport --dports $port1:$port2 -d $wanIP -j DNAT --to $ip
				iptables -A PREROUTING -t nat -p UDP -m multiport --dports $port1:$port2 -d $wanIP -j DNAT --to $ip
#				iptables -A POSTROUTING -t nat -p TCP -m multiport --dports $port1:$port2 -d $ip -j SNAT --to $1
#				iptables -A POSTROUTING -t nat -p UDP -m multiport --dports $port1:$port2 -d $ip -j SNAT --to $1
				iptables -A POSTROUTING -t nat -p TCP -s $IP_ADDR/$SUBNET_MASK -m multiport --dports $port1:$port2 -d $ip -j SNAT --to $1
				iptables -A POSTROUTING -t nat -p UDP -s $IP_ADDR/$SUBNET_MASK -m multiport --dports $port1:$port2 -d $ip -j SNAT --to $1
			fi
	    fi

		if [ "$port1" -le "1723" ] && [ "$port2" -ge "1723" ]; then
			iptables -A PREROUTING -t nat -p 47 -d $wanIP -j DNAT --to $ip
			iptables -A POSTROUTING -t nat -p 47 -s $IP_ADDR/$SUBNET_MASK -d $ip -j SNAT --to $1
		fi

		
	done
fi
