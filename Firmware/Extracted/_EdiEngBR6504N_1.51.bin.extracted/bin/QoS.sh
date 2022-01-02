#!/bin/sh

#sleep 1
echo "-----> Quality of Service"

#include file
. /var/flash.inc

#WAN1=eth1	#Erwin
#WAN2=eth1
#WAN3=eth2
#WAN4=eth3

TMP1=/var/qos1
TMP1=/var/qos2

T1=`ip route | grep via | cut -f 2 | grep eth1 | cut -f 2-6 -d" "`

#if [ "$WAN_MODE" = "2" -o "$WAN_MODE" = "3" -o "$WAN_MODE" = "6" ]; then
#	WAN1=ppp0
#fi

	WAN1=eth1

# if wireless ISP mode , set WAN to wlan0-vxd

	if [ "$OP_MODE" = "1" ];then
		#WAN1=wlan$WISP_WAN_ID-vxd
		WAN1=br1
	fi
	
#PPoE
	if [ "$WAN_MODE" = "2" ]; then
		WAN1=ppp0
		WAN2=ppp1
	fi

#PPtP
	if [ "$WAN_MODE" = "3" ]; then
		WAN1=ppp0
	fi

#L2TP
	if [ "$WAN_MODE" = "6" ]; then
		WAN1=ppp0
	fi

#WANLIST="1 2 3 4"
if [ "$WAN_MODE" = "2" ]; then
	WANLIST="1 2"
else
	WANLIST="1"
fi

tc qdisc del dev br0 root handle 8888: htb default 9999

if [ "$WAN1_QOS_ENABLED" = "0" ] || [ "$WAN1_QOS_TBL_NUM" = "0" ]; then
      exit 0
else 
	rmmod fv_fastnat 2> /dev/null
fi

ifconfig br0 down

tc qdisc add dev br0 root handle 8888: htb default 9999
tc class add dev br0 parent 8888: classid 8888:8888 htb rate 100000kbit ceil 100000kbit
tc class add dev br0 parent 8888:8888 classid 8888:9999 htb rate 1kbit ceil 100000kbit prio 1

#----Added by joseph Chen , Dec 16, 2005-----------
tc qdisc add dev br0 parent 8888:9999 handle 999: sfq perturb 10

#--------------------------------------------------



for wl in $WANLIST
do
	eval enabled=\$WAN"$wl"_QOS_ENABLED
	if [ "$enabled" = "1" ]; then
		# delete old foward rule
		ip rule | grep T$wl | grep fwmark > $TMP1
		while [ -s $TMP1 ]
		do
			TMP2=`head -n 1 $TMP1`
			mnum=`echo $TMP2 | cut -f 5 -d " "`
			ip rule del fwmark $mnum
			ip rule | grep T$wl | grep fwmark> $TMP1
		done

		eval WAN=\$WAN$wl
		tc qdisc del dev $WAN root
		
		rmmod fv_fastnat 2> /dev/null
		/bin/QoS -W $wl -I $WAN
	fi
done

ifconfig br0 up

rm -f $TMP1
rm -f $TMP2
echo "-----------------------"

