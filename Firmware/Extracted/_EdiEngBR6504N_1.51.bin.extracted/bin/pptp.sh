#!/bin/sh
WAN=eth1
OPTIONS=/etc/ppp/options.pptp
PAPFILE=/etc/ppp/pap-secrets0
CHAPFILE=/etc/ppp/chap-secrets0
RESOLV=/etc/ppp/resolv.conf
LINKFILE=/etc/ppp/link
PPPFILE=/var/run/ppp
FIRSTFILE=/etc/ppp/first0
START_DHCP_CLIENT=dhcpc.sh
TEMPFILE=/var/run/jj3
DISCONNECT=disconnect.sh

#include file
. /var/flash.inc

if [ "$1" = 'connect' ]; then
     ENABLE_CONNECT=1
else
     ENABLE_CONNECT=0
fi

rm $TEMPFILE 2> /dev/null
cp /etc/ppp/options.orig /etc/ppp/options0

if [ -n "$PPTP_CONNT_ID" ]; then
	echo -n " --phone $PPTP_CONNT_ID" >> $TEMPFILE
fi

if [ "$PPTP_BEZEQ_ENABLED" = "1" ]; then
	echo -n " --quirks BEZEQ_ISRAEL" >> $TEMPFILE
fi

echo " " >> $TEMPFILE
pat=`head -n 1 $TEMPFILE | tail -n 1`

if [ -n "$PPTP_USER_NAME" ]; then
#  echo $PPTP_USER_NAME > $OPTIONS
#  sed 's/#/\\#/g' $OPTIONS > usrTmp
#  NEW_USER_NAME=`cat usrTmp`
  echo "name $PPTP_USER_NAME" > $OPTIONS
  echo "#################################################" > $PAPFILE  
  echo "$PPTP_USER_NAME	*	$PPTP_PASSWORD" >> $PAPFILE
  echo "#################################################" > $CHAPFILE
  echo "$PPTP_USER_NAME	*	$PPTP_PASSWORD" >> $CHAPFILE
fi

MTU=`expr $PPTP_MTU + 8`

echo "noipdefault" >> $OPTIONS  
echo "hide-password" >> $OPTIONS  
echo "defaultroute" >> $OPTIONS  
echo "noauth" >> $OPTIONS  
echo "ipcp-accept-remote" >> $OPTIONS  
echo "ipcp-accept-local" >> $OPTIONS  
echo "nodetach" >> $OPTIONS  
echo "usepeerdns" >> $OPTIONS  
echo "lcp-echo-interval 2" >> $OPTIONS  
echo "lcp-echo-failure 20" >> $OPTIONS  
echo "lock" >> $OPTIONS  
echo "mtu $MTU" >> $OPTIONS
echo "mru $MTU" >> $OPTIONS
#echo "refuse-eap" >> $OPTIONS

PID_FILE=/var/run/ppp0.pid
#DNRD_PID=/var/run/dnrd.pid

if [ "$PPTP_CONNECT_TYPE" = "1" ]; then
	echo "connect /sbin/chat" >> $OPTIONS
	echo "demand" >> $OPTIONS
	echo "idle $PPTP_IDLE_TIME" >> $OPTIONS
  	echo "active-filter 'outbound and (udp or tcp[13] & 4 = 0 or icmp[0]=8 or icmp[0]=13 or icmp[0]=15)'" >> $OPTIONS
else
	echo "persist" >> $OPTIONS
fi

$DISCONNECT pptp

if [ "$PPTP_CONNECT_TYPE" != "2" ]; then
{
	while [ true ]; do
		if [ ! -f "$PID_FILE" ]; then
			$DISCONNECT pptp 
			if [ "$PPTP_IPMODE" = "0" ]; then
				$START_DHCP_CLIENT $WAN wait 
				/usr/bin/route del -net default
			else
				/sbin/ifconfig $WAN $PPTP_IP_ADDR netmask $PPTP_IP_MASK_ADDR 
				if [ "$PPTP_DEF_GATEWAY" != "0.0.0.0" ]; then
					/usr/bin/route add -host $PPTP_GATEWAY gw $PPTP_DEF_GATEWAY
				fi
			fi
				            
			PPTP_GW_IP=$(route -n | grep UGH | cut -f1 -d' ')
			
			if [ "$PPTP_GW_IP" = "" ]; then
				PPTP_GW_IP=$PPTP_GATEWAY
			fi
				
			/bin/pptp $PPTP_GW_IP $pat file $OPTIONS & 
  	fi
	  	sleep 5
	done
} &
fi

if [ "$PPTP_CONNECT_TYPE" = "2" ] && [ "$ENABLE_CONNECT" = "1" ]; then
{

	$DISCONNECT pptp

    echo "$WAN_MODE" > /tmp/old_mode

	if [ "$PPTP_IPMODE" = "0" ]; then
		$START_DHCP_CLIENT $WAN wait 
		/usr/bin/route del -net default
	else
		/sbin/ifconfig $WAN $PPTP_IP_ADDR netmask $PPTP_IP_MASK_ADDR 
		if [ "$PPTP_DEF_GATEWAY" != "0.0.0.0" ]; then
			/usr/bin/route add -host $PPTP_GATEWAY gw $PPTP_DEF_GATEWAY
		fi
	fi
				            
	PPTP_GW_IP=$(route -n | grep UGH | cut -f1 -d' ')
			
	if [ "$PPTP_GW_IP" = "" ]; then
		PPTP_GW_IP=$PPTP_GATEWAY
	fi
				
	/bin/pptp $PPTP_GW_IP $pat file $OPTIONS & 
} &
fi
