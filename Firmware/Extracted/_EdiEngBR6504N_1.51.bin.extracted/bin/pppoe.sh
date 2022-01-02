#!/bin/sh
#WAN=eth1
OPTIONS0=/etc/ppp/options0
OPTIONS1=/etc/ppp/options1
PAPFILE=/etc/ppp/pap-secrets
PAPFILE0=/etc/ppp/pap-secrets0
PAPFILE1=/etc/ppp/pap-secrets1
CHAPFILE=/etc/ppp/chap-secrets
CHAPFILE0=/etc/ppp/chap-secrets0
CHAPFILE1=/etc/ppp/chap-secrets1
RESOLV=/etc/ppp/resolv.conf
LINKFILE=/etc/link
PPPFILE=/var/run/ppp
FIRSTFILE0=/etc/ppp/first0
FIRSTFILE1=/etc/ppp/first1
LOCKFILE=/etc/ppp/lockconn

#include file
. /var/flash.inc

WAN=eth1
WAN2=eth1
if [ "$OP_MODE" = "1" ];then
	#WAN=wlan$WISP_WAN_ID-vxd
	WAN=br1
fi
	
MTU=`expr $PPP_MTU + 8`
MTU1=`expr $PPP_MTU1 + 8`

if [ "$1" = 'connect' ]; then
	if [ "$2" = '1' ]; then
     		ENABLE_CONNECT1=1
	else
		ENABLE_CONNECT=1
	fi
else
	if [ "$2" = '1' ]; then
     		ENABLE_CONNECT1=0
	else
		ENABLE_CONNECT=0
	fi
fi

# AlexLien: make interface up for ppp connect
#ifconfig $WAN down
#ifconfig $WAN up
#ifconfig $WAN2 up

if [ -n "$PPP_USER_NAME" ] ; then
  echo "name \"$PPP_USER_NAME\"" > $OPTIONS0

#  echo "#################################################" > $PAPFILE
#  echo "\"$PPP_USER_NAME\"	*	\"$PPP_PASSWORD\" *" >> $PAPFILE
#  echo "#################################################" > $CHAPFILE
#  echo "\"$PPP_USER_NAME\"	*	\"$PPP_PASSWORD\" *" >> $CHAPFILE

  echo "#################################################" > $PAPFILE0
  echo "\"$PPP_USER_NAME\"	*	\"$PPP_PASSWORD\" *" >> $PAPFILE0
  echo "#################################################" > $CHAPFILE0
  echo "\"$PPP_USER_NAME\"	*	\"$PPP_PASSWORD\" *" >> $CHAPFILE0
fi

if [ -n "$PPP_USER_NAME1" ] ; then
  echo "name \"$PPP_USER_NAME1\"" > $OPTIONS1

#  echo "#################################################" >> $PAPFILE
#  echo "\"$PPP_USER_NAME1\"	*	\"$PPP_PASSWORD1\" *" >> $PAPFILE
#  echo "#################################################" >> $CHAPFILE
#  echo "\"$PPP_USER_NAME1\"	*	\"$PPP_PASSWORD1\" *" >> $CHAPFILE

  echo "#################################################" > $PAPFILE1
  echo "\"$PPP_USER_NAME1\"	*	\"$PPP_PASSWORD1\" *" >> $PAPFILE1
  echo "#################################################" > $CHAPFILE1
  echo "\"$PPP_USER_NAME1\"	*	\"$PPP_PASSWORD1\" *" >> $CHAPFILE1
fi

echo "noipdefault" >> $OPTIONS0  
echo "hide-password" >> $OPTIONS0  
echo "ipcp-accept-remote" >> $OPTIONS0  
echo "ipcp-accept-local" >> $OPTIONS0  
echo "nodetach" >> $OPTIONS0  
echo "usepeerdns" >> $OPTIONS0  
echo "lcp-echo-interval 2" >> $OPTIONS0  
echo "lcp-echo-failure 20" >> $OPTIONS0  
echo "lock" >> $OPTIONS0  
echo "mtu $PPP_MTU" >> $OPTIONS0
echo "mru $MTU" >> $OPTIONS0
echo "sync" >> $OPTIONS0
echo "unit 0" >> $OPTIONS0
echo "defaultroute" >> $OPTIONS0
#echo "refuse-eap" >> $OPTIONS0

echo "noipdefault" >> $OPTIONS1  
echo "hide-password" >> $OPTIONS1  
echo "ipcp-accept-remote" >> $OPTIONS1  
echo "ipcp-accept-local" >> $OPTIONS1  
echo "nodetach" >> $OPTIONS1
echo "usepeerdns" >> $OPTIONS1  
echo "lcp-echo-interval 2" >> $OPTIONS1  
echo "lcp-echo-failure 3" >> $OPTIONS1  
echo "lock" >> $OPTIONS1  
echo "mtu $PPP_MTU" >> $OPTIONS1
echo "mru $MTU" >> $OPTIONS1
echo "sync" >> $OPTIONS1
echo "unit 1" >> $OPTIONS1
echo "nodefaultroute" >> $OPTIONS1
#the following option is for multiple pppoe of Japan
echo "noproxyarp" >> $OPTIONS1
#echo "refuse-eap" >> $OPTIONS0

#pppoa mode
#if [ "$ADSL_ENCAP" != '2' ] && [ "$ADSL_ENCAP" != '3' ]; then
	if [ "$PPP_SERVNAME" != "" ]; then
	  echo "plugin /etc/ppp/plugins/libplugin.a rp_pppoe_service $PPP_SERVNAME $WAN" >> $OPTIONS0
	else
	  echo "plugin /etc/ppp/plugins/libplugin.a $WAN" >> $OPTIONS0
	fi
	
	if [ "$PPP_SERVNAME1" != "" ]; then
	  echo "plugin /etc/ppp/plugins/libplugin.a rp_pppoe_service $PPP_SERVNAME1 $WAN2" >> $OPTIONS1
	else
	  echo "plugin /etc/ppp/plugins/libplugin.a $WAN2" >> $OPTIONS1
	fi
#fi

PID_FILE=/var/run/ppp0.pid
PID_FILE1=/var/run/ppp1.pid
#DNRD_PID=/var/run/dnrd.pid

/bin/disconnect.sh pppoe

if [ "$PPP_CONNECT_TYPE" = "1" ] ; then
    echo "demand" >> $OPTIONS0
    echo "idle $PPP_IDLE_TIME" >> $OPTIONS0
    echo "active-filter 'outbound and (udp or tcp[13] & 4 = 0 or icmp[0]=8 or icmp[0]=13 or icmp[0]=15)'" >> $OPTIONS0
else
	echo "persist" >> $OPTIONS0  
fi

if [ "$PPP_CONNECT_TYPE1" = "1" ] ; then
    echo "demand" >> $OPTIONS1
    echo "idle $PPP_IDLE_TIME1" >> $OPTIONS1
    echo "active-filter 'outbound and (udp or tcp[13] & 4 = 0 or icmp[0]=8 or icmp[0]=13 or icmp[0]=15)'" >> $OPTIONS1
else
	echo "persist" >> $OPTIONS1  
fi

if [ "$PPPoEMODE" = "1" -o "$PPPoEMODE" = "2" ] ; then
	if [ "$PPP_UNNUMIP" != "0.0.0.0" ]; then
		ifconfig br0:1 $PPP_UNNUMIP netmask $PPP_UNNUMMASK
	fi
fi	

if [ "$PPP_CONNECT_TYPE" != "2" ] ; then
	echo "lock" >> $LOCKFILE
	if [ ! -f $FIRSTFILE0 ]; then
	{
		echo "pass" >> $FIRSTFILE0
		while [ true ]; do
			if [ ! -r "$PID_FILE" ]  && [ "$PPP_CONNECT_TYPE" != "2" ]; then
				/bin/disconnect.sh pppoe 0 
				sleep 2		
				pppd 0 
			fi
			sleep 5
			#  time=`expr $time + $time_poll`
		done
	} &
	fi
fi

if [ "$PPP_CONNECT_TYPE1" != "2" ] && [ "$PPPoEMODE" = "2" ] ; then
	while [ -f $LOCKFILE ]; do
		sleep 20
	done
	if [ ! -f $FIRSTFILE1 ]; then
	{
		echo "pass" >> $FIRSTFILE1
		while [ true ]; do
			if [ ! -r "$PID_FILE1" ]  && [ "$PPP_CONNECT_TYPE1" != "2" ]; then
				/bin/disconnect.sh pppoe 1
				sleep 2		
				pppd 1 
			fi
			sleep 5
			#  time=`expr $time + $time_poll`
		done
	} &
	fi
fi

if [ "$PPP_CONNECT_TYPE" = "2" ] && [ "$ENABLE_CONNECT" = "1" ]; then
	/bin/disconnect.sh pppoe 0

    echo "$WAN_MODE" > /tmp/old_mode

	sleep 2
	pppd 0 &
fi

if [ "$PPP_CONNECT_TYPE1" = "2" ] && [ "$ENABLE_CONNECT1" = "1" ]; then
	/bin/disconnect.sh pppoe 1

    echo "$WAN_MODE" > /tmp/old_mode1

	sleep 2
	pppd 1 &
fi

