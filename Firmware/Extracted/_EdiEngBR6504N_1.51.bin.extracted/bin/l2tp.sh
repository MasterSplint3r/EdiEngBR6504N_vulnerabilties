#!/bin/sh

#include file
. /var/flash.inc

WAN=eth1
START_DHCP_CLIENT=dhcpc.sh
DISCONNECT=/bin/disconnect.sh
PID_FILE=/var/run/ppp0.pid
CONF_FILE=/etc/l2tp/l2tp.conf
PPP_L2TP=/etc/ppp/options.l2tpd

L2TP_LOG=/var/log/l2tp.err

cp /etc/ppp/options.orig /etc/ppp/options0

# move to create_l2tp_conf.sh
# create /etc/l2tp/l2tp.conf
#echo "global" > $CONF_FILE
#echo "load-handler \"/bin/handlers/sync-pppd.so\"" >> $CONF_FILE
#echo "load-handler \"/bin/handlers/cmd.so\"" >> $CONF_FILE
#echo "listen-port 1701" >> $CONF_FILE
#echo "section sync-pppd" >> $CONF_FILE
#echo "lac-pppd-opts \"file /etc/ppp/options.l2tpd\"" >> $CONF_FILE
#echo "section peer" >> $CONF_FILE
#echo "peer $L2TP_GATEWAY" >> $CONF_FILE
#echo "port 1701" >> $CONF_FILE
#echo "lac-handler sync-pppd" >> $CONF_FILE
#echo "retain-tunnel 1" >> $CONF_FILE
#echo "section cmd" >> $CONF_FILE


# create /etc/ppp/optins.l2tpd
MTU=`expr $L2TP_MTU + 8`

echo "user $L2TP_USER_NAME" > $PPP_L2TP
echo "remotename none" >> $PPP_L2TP
echo "asyncmap 0" >> $PPP_L2TP
echo "defaultroute" >> $PPP_L2TP
echo "noauth" >> $PPP_L2TP
echo "mru $MTU" >> $PPP_L2TP
echo "mtu $MTU" >> $PPP_L2TP
echo "lcp-echo-interval 2" >> $PPP_L2TP
echo "lcp-echo-failure 20" >> $PPP_L2TP
#echo "refuse-eap" >> $PPP_L2TP


# /etc/ppp/pap-secrets
echo "$L2TP_USER_NAME * $L2TP_PASSWORD *" > /etc/ppp/pap-secrets0
echo "$L2TP_USER_NAME * $L2TP_PASSWORD *" > /etc/ppp/chap-secrets0

if [ "$L2TP_CONNECT_TYPE" = "1" ]; then
	echo "connect /sbin/chat" >> $PPP_L2TP
	echo "demand" >> $PPP_L2TP
	echo "idle $L2TP_IDLE_TIME" >> $PPP_L2TP
	echo "active-filter 'outbound and (udp or tcp[13] & 4 = 0 or icmp[0]=8 or icmp[0]=13 or icmp[0]=15)'" >> $PPP_L2TP
else
	echo "persist" >> $PPP_L2TP
fi

$DISCONNECT l2tp

if [ "$L2TP_CONNECT_TYPE" != "2" ]; then
	{
	while [ true ]; do
  		if [ ! -f "$PID_FILE" ]; then
			dnrd -k
			/usr/bin/killall l2tpd 2> /dev/null
			/usr/bin/killall pppd 0 2> /dev/null
			$DISCONNECT l2tp
			if [ "$L2TP_IPMODE" = "0" ]; then
				$START_DHCP_CLIENT $WAN wait 
				/usr/bin/route del -net default
				wan-status.sh
			else
				/sbin/ifconfig $WAN $L2TP_IP_ADDR netmask $L2TP_MASK_ADDR 
               	if [ "$L2TP_DEFGATEWAY" != "0.0.0.0" ]; then
					/usr/bin/route add -host $L2TP_GATEWAY gw $L2TP_DEFGATEWAY                        
				fi
			fi

			L2TP_GW_IP=$(route -n | grep UGH | cut -f1 -d' ')
				
			if [ "$L2TP_GW_IP" = "" ]; then
				L2TP_GW_IP=$L2TP_GATEWAY
			fi
			
			/bin/create_l2tp_conf.sh $L2TP_GW_IP

#			l2tpd -f -d 65535 2>> $L2TP_LOG &
			l2tpd -f &
			
			sleep 1

			/bin/handlers/l2tp-control "start-session $L2TP_GW_IP"	
	  	fi
		sleep 5
	done
	} &
fi

if [ "$L2TP_CONNECT_TYPE" = "2"  ] && [ "$1" = "connect" ]; then
	{
	dnrd -k
    /usr/bin/killall l2tpd 2> /dev/null
    /usr/bin/killall pppd 0 2> /dev/null								

    echo "$WAN_MODE" > /tmp/old_mode

	if [ "$L2TP_IPMODE" = "0" ]; then
		$START_DHCP_CLIENT $WAN wait
		wan-status.sh
        ip=`head -n 1 /var/run/dns-tmp | tail -n 1`
	else
		/sbin/ifconfig $WAN $L2TP_IP_ADDR netmask $L2TP_MASK_ADDR 
		if [ "$L2TP_DEFGATEWAY" != "0.0.0.0" ]; then
			/usr/bin/route add -host $L2TP_GATEWAY gw $L2TP_DEFGATEWAY
		fi
	fi
	
	L2TP_GW_IP=$(route -n | grep UGH | cut -f1 -d' ')
	if [ "$L2TP_GW_IP" = "" ]; then
		L2TP_GW_IP=$L2TP_GATEWAY
	fi
	
	/bin/create_l2tp_conf.sh $L2TP_GW_IP
																					
#	l2tpd -f -d 65535 2>> $L2TP_LOG &
	l2tpd -f &
    sleep 1
   	 /bin/handlers/l2tp-control "start-session $L2TP_GW_IP"
	
	} &
fi
