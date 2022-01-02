#!/bin/sh
#  $1 : INT_IP

#sleep 1
WAN1=eth1

echo "-----> DMZ"

#include file
. /var/flash.inc

if [ "$WAN_MODE" = "2" -o "$WAN_MODE" = "3" -o "$WAN_MODE" = "6" ]; then
  WAN1=ppp0
  WAN2=ppp1
fi

if [ "$FIREWALL_ENABLE" = "0" ]; then
	DMZ_ENABLED=0
fi

#DMZ_TBL_NUM=2
#DMZ_TBL1=1,1,192.168.12.224,192.168.2.33,0
#DMZ_TBL2=1,1,192.168.12.223,192.168.2.34,0
#DMZ_ENABLED=1


#wanIP1=`ifconfig $WAN1 | grep inet | cut -f 2 -d":" | cut -f 1 -d" "`
#if [ "$wanIP1" != "" ]; then 
#	echo $wanIP1 > /var/w1.ip
#fi

#if [ "$WAN2" != "" ]; then
#	wanIP2=`ifconfig $WAN2 | grep inet | cut -f 2 -d":" | cut -f 1 -d" "`
#	if [ "$wanIP2" != "" ]; then 
#		echo $wanIP2 >> /var/w1.ip
#	fi
#fi

if [ "$DMZ_ENABLED" = "1" ] ; then

	list="1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20"

	if [ $DMZ_TBL_NUM -ge 1 ]; then
		for items in $list
		do
			eval TMP_TBL=\$DMZ_TBL$items

			if [ "$TMP_TBL" = "" ]; then
				continue
			fi

			echo $TMP_TBL
			
			mode=`echo $TMP_TBL | cut -f 1 -d","`
			session=`echo $TMP_TBL | cut -f 2 -d","`
			wanIP=`echo $TMP_TBL | cut -f 3 -d","`
			lanIP=`echo $TMP_TBL | cut -f 4 -d","`

			eval WAN_ITEM=\$WAN$session

			if [ "$mode" = "0" ]; then
				eval wanIP=`ifconfig $WAN_ITEM | grep inet | cut -f 2 -d":" | cut -f 1 -d" "`
				if [ "$wanIP" != "" ]; then
					eval echo $wanIP > /var/w$session.ip
				else
					continue
				fi
			else
				eval netmask=`ip addr show dev $WAN_ITEM | grep inet | cut -f 2 -d"/" | cut -f 1 -d" " | head -n 1`
				eval broadcast=`ip addr show dev $WAN_ITEM | grep inet | cut -f 2 -d"/" | cut -f 3 -d" " | head -n 1`
				eval ip addr add $wanIP/$netmask broadcast $broadcast dev $WAN_ITEM
				eval echo ip addr add $wanIP/$netmask broadcast $broadcast dev $WAN_ITEM

				if [ "$netmask" = "" ]; then
					continue
				fi
			fi

			echo iptables -A PREROUTING -t nat -p all -d $wanIP -j DNAT --to $lanIP
			echo iptables -A POSTROUTING -t nat -p ALL -s $IP_ADDR/$SUBNET_MASK -d $lanIP -j SNAT --to $1
			iptables -A PREROUTING -t nat -p all -d $wanIP -j DNAT --to $lanIP
			#	iptables -A POSTROUTING -t nat -p ALL -d $DMZ_HOST -j SNAT --to $1
			iptables -A POSTROUTING -t nat -p ALL -s $IP_ADDR/$SUBNET_MASK -d $lanIP -j SNAT --to $1

			if [ $items -eq $DMZ_TBL_NUM ]; then
				break
			fi
		done
	fi
fi

