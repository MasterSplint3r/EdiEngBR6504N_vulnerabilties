#!/bin/sh
#
# script file to start network
#
# Usage: init.sh {gw | ap} {all | bridge | wan}
#

if [ $# -lt 2 ]; then echo "Usage: $0 {gw | ap} {all | bridge | wan}"; exit 1 ; fi
#MODE=`cat /web/mode`
. /web/mode
TOOL=flash
GETMIB="$TOOL get"
LOADDEF="$TOOL default"
LOADDS="$TOOL reset"
SETMIB="$TOOL set"
SET_IP=fixedip.sh
START_DHCP_SERVER=dhcpd.sh
START_DHCP_CLIENT=dhcpc.sh
START_BRIDGE=bridge.sh
START_WLAN=wlan.sh
START_PPPOE=pppoe.sh
START_PPTP=pptp.sh
START_FIREWALL=firewall.sh
START_DISCONNECT=disconnect.sh
START_L2TP=l2tp.sh
START_BPA=bpa.sh
DISCONNECT=2
FIRSTFILE0=/etc/ppp/first0
FIRSTFILE1=/etc/ppp/first1
#START_IAPP_8021X=iappauth.sh
START_WLAN_APP=wlanapp.sh	#Erwin
SEC_LOG=/var/log/security
WLAN_INTERFACE=ra0
#MODE=`cat /web/mode`
. /web/mode
# See if flash data is valid
$TOOL test-hwconf
if [ $? != 0 ]; then
	echo 'HW configuration invalid, reset default!'
	$LOADDEF
fi

$TOOL test-dsconf
if [ $? != 0 ]; then
	echo 'Default configuration invalid, reset default!'
	$LOADDEF
fi

#$TOOL test-csconf		#removed by Erwin
#if [ $? != 0 ]; then
#	echo 'Current configuration invalid, reset to default configuration!'
#	$LOADDS
#fi

#create include file
#if [ -f /var/flash.inc ]; then
#	echo "don't create flash.inc"
#else
#	echo "create flash.inc"




##################################################


	flash all2 > /var/flash.inc
	
#fi

#include file
. /var/flash.inc 

if [ "$MODE" = "-D_topcom_" ] && [ "$IS_RESET_DEFAULT" = 0 ]; then
	
	/bin/setssidmac.sh 
	
fi
# -----------------------------------


ifconfig ra0 down 2> /dev/null
ifconfig ra1 down 2> /dev/null
ifconfig ra2 down 2> /dev/null
ifconfig ra3 down 2> /dev/null
ifconfig ra4 down 2> /dev/null
            
brctl delif br0 ra0 2> /dev/null
brctl delif br0 ra1 2> /dev/null
brctl delif br0 ra2 2> /dev/null
brctl delif br0 ra3 2> /dev/null
brctl delif br0 ra4 2> /dev/null

rmmod rt2860ap    2> /dev/null



#insmod /bin/rt61ap.o
#------------------------------------

if [ "$1" = 'ap' ]; then
### bridge (eth0+ra0) confiuration #########
	GATEWAY='false'
	BR_INTERFACE=br0
	WLAN_INTERFACE=ra0
	BR_LAN1_INTERFACE=eth0
	#BR_LAN2_INTERFACE=$WLAN_INTERFACE
##############################################
fi

if [ "$1" = 'gw' ]; then
### gateway (eth0+eth1+ra0) configuration ##
	GATEWAY='true'
	if [ "$OP_MODE" = '1' ];then
		WAN_INTERFACE=ra$WISP_WAN_ID
	else
		WAN_INTERFACE=eth1
	fi	
	#WAN_INTERFACE=eth1
	BR_INTERFACE=br0
	WLAN_INTERFACE=ra0
	BR_LAN1_INTERFACE=eth0
	if [ "$OP_MODE" = '1' ];then
		BR_LAN2_INTERFACE=eth1
	#else
		#BR_LAN2_INTERFACE=$WLAN_INTERFACE
	fi
##############################################
fi

if [ "$2" = 'all' ]; then
	ENABLE_WAN=1
	ENABLE_BR=1
elif [ "$2" = 'wan' ]; then
	ENABLE_WAN=1
	ENABLE_BR=0
elif [ "$2" = 'bridge' ]; then
	# if WISP mode , restart wan  for pppoe  ,pptp
	if [ "$OP_MODE" = '2' ]; then 
		ENABLE_WAN=1
	else
		ENABLE_WAN=0
	fi
	ENABLE_BR=1
elif [ $2 = 'wlan_app' ]; then
	$START_WLAN_APP start $WLAN_INTERFACE $BR_INTERFACE
	exit 0  
else
	echo "Usage: $0 {all | bridge | wan | wlan_app}"; exit 1
fi

# When configured as AP, update DHCP value if it is invalid
#if [ "$GATEWAY" = 'false' ]; then
#	if [ "$DHCP" = '2' ]; then
#		$TOOL set DHCP 0
#	fi
#
#	if [ "$DEF_DHCP" = '2' ]; then
#		$TOOL set DEF_DHCP 0
#	fi
#fi

# Set Ethernet0 MAC address
if [ "$ELAN_MAC_ADDR" = "000000000000" ]; then
	ELAN_MAC_ADDR=$HW_NIC0_ADDR
fi

ifconfig $BR_LAN1_INTERFACE down
ifconfig $BR_LAN1_INTERFACE hw ether $ELAN_MAC_ADDR
ifconfig $BR_LAN1_INTERFACE up 
#ifconfig $BR_LAN1_INTERFACE down 
#ifconfig $BR_LAN1_INTERFACE up 

#set Ethernet 1 MAC Address for bridge mode and WISP
if [ "$OP_MODE" = '1' ]; then
	if [ "$ELAN_MAC_ADDR" = "000000000000" ]; then
		ELAN_MAC_ADDR=$HW_NIC1_ADDR
	fi
	ifconfig $BR_LAN2_INTERFACE hw ether $ELAN_MAC_ADDR
fi

if [ "$GATEWAY" = 'true' ]; then
	if [ "$WAN_MAC_ADDR" = "000000000000" ]; then
		if [ "$OP_MODE" = '1' ]; then  #wireless ISP, use the WLAN mac address
			WAN_MAC_ADDR=$HW_WLAN_ADDR
		else
			WAN_MAC_ADDR=$HW_NIC1_ADDR
		fi
	fi
	
	ifconfig $WAN_INTERFACE down
	ifconfig $WAN_INTERFACE hw ether $WAN_MAC_ADDR
	ifconfig $WAN_INTERFACE up
#	ifconfig $WAN_INTERFACE down
#	ifconfig $WAN_INTERFACE up
fi

if [ $ENABLE_WAN = 1 -a "$GATEWAY" = 'true' ]; then  #disconnect all wan  for vpn and wisp
	# stop vpn if enabled
#	if [ -f $PLUTO_PID ];then
#		ipsec setup stop
#	fi	
	killall -9 pptp.sh
	killall -9 pppoe.sh
	rm -f /var/ppp/first*
	disconnect.sh all
fi

# Start WLAN interface
if [ "$ENABLE_BR" = "1" ] && [ -n "$WLAN_INTERFACE" ]; then
	echo 'Initialize WLAN interface'
	$START_WLAN $WLAN_INTERFACE
fi

# check repeater interface for ra0
WLAN_INTERFACE_REPEATER=$WLAN_INTERFACE

if [ "$GATEWAY" = 'true' ]; then

	if [ "$ENABLE_BR" = "1" ]; then
		echo 'Setup BRIDGE interface'

		#Initialize bridge interface
		
		# start Bridge
		# $START_BRIDGE $BR_INTERFACE $BR_LAN1_INTERFACE $WLAN_INTERFACE $BR_LAN2_INTERFACE
		$START_BRIDGE $BR_INTERFACE $BR_LAN1_INTERFACE $WLAN_INTERFACE_REPEATER $BR_LAN2_INTERFACE
		$START_WLAN_APP $WLAN_INTERFACE 		# 802.1x daemon will kill itself after interface down

		# Set fixed IP or start DHCP server
		PIDFILE=/var/run/udhcpd.pid
		if [ -f $PIDFILE ] ; then
			PID=`cat $PIDFILE`
			if [ "$PID" != "0" ]; then
				kill -9 $PID 2> /dev/null
        		fi
			rm -f $PIDFILE 2> /dev/null
		fi

		if [ "$DHCP" = '0' ]; then
			$SET_IP $BR_INTERFACE $IP_ADDR $SUBNET_MASK $DEFAULT_GATEWAY

		elif [ "$DHCP" = '2' ]; then
			sleep 1
			$START_DHCP_SERVER $BR_INTERFACE
#		else
#			echo 'Invalid DHCP MIB value for LAN interface!'
		fi
	fi

#	$START_WLAN_APP start $WLAN_INTERFACE $BR_INTERFACE  # Tommy # 802.1x daemon will kill itself after interface down
	
	if [ "$ENABLE_WAN" = "1" ]; then
		echo 'Setup WAN interface'
		$START_DISCONNECT all
        
		rm $FIRSTFILE0 2> /dev/null
		rm $FIRSTFILE1 2> /dev/null
		rm jj1 2> /dev/null
		rm jj2 2> /dev/null
		
		# Initialize WAN interface

		route del default 2> /dev/null
		
		PRESS=`cat /dev/switch2`
		if [ "$WAN_MODE" != '5' ] && [ "$PRESS" != "0" ]; then
			brctl delif $BR_INTERFACE $WAN_INTERFACE 2> /dev/null
		fi
		if [ "$PRESS" != "0" ]; then 
			#Router Mode
			flash set AP_ROUTER_SWITCH 0
			echo "$WAN_MODE" > /tmp/old_mode
		
			if [ "$WAN_MODE" = '1' ]; then
				echo [`date +"%F %T"`]: start Static IP >> $SEC_LOG
				$SET_IP $WAN_INTERFACE $WAN_IP_ADDR $WAN_SUBNET_MASK $WAN_DEFAULT_GATEWAY
				/etc/ppp/ip-up static
			elif [ "$WAN_MODE" = '0' ]; then
				echo [`date +"%F %T"`]: start Dynamic IP >> $SEC_LOG
				$START_DHCP_CLIENT $WAN_INTERFACE wait&
			elif [ "$WAN_MODE" = '2' ]; then
				echo [`date +"%F %T"`]: start PPPoE daemon >> $SEC_LOG
				$START_PPPOE all &		
			elif [ "$WAN_MODE" = '3' ]; then
				echo [`date +"%F %T"`]: start PPtP daemon >> $SEC_LOG
				$START_PPTP
				sleep 2
			elif [ "$WAN_MODE" = '4' ]; then
				echo [`date +"%F %T"`]: start BPA daemon >> $SEC_LOG
				$START_DHCP_CLIENT $WAN_INTERFACE wait&
				$START_BPA
			elif [ "$WAN_MODE" = '5' ]; then
				echo [`date +"%F %T"`]: start Bridge daemon >> $SEC_LOG
				$START_BRIDGE $BR_INTERFACE $BR_LAN1_INTERFACE $WLAN_INTERFACE $BR_LAN2_INTERFACE
				brctl addif $BR_INTERFACE $WAN_INTERFACE
				ifconfig $BR_INTERFACE $IP_ADDR
			elif [ "$WAN_MODE" = '6' ]; then
				echo [`date +"%F %T"`]: start L2tp daemon >> $SEC_LOG
				$START_L2TP
				sleep 2
			else
				echo "Invalid DHCP MIB value for WAN interface! WAN_MODE= $WAN_MODE"
			fi
		else  
				flash set AP_ROUTER_SWITCH 1
				echo Bridge WAN to LAN
				echo [`date +"%F %T"`]: start Bridge daemon >> $SEC_LOG
				$START_BRIDGE $BR_INTERFACE $BR_LAN1_INTERFACE $WLAN_INTERFACE $BR_LAN2_INTERFACE
				brctl addif $BR_INTERFACE $WAN_INTERFACE
				ifconfig $BR_INTERFACE $IP_ADDR			
				
		fi
		
	fi
else
	# Delete DHCP client process
	PIDFILE=/etc/udhcpc/udhcpc-$BR_INTERFACE.pid
	if [ -f $PIDFILE ] ; then
		PID=`cat $PIDFILE`
		if [ "$PID" != "0" ]; then
			kill -9 $PID 2> /dev/null
       	fi
   		rm -f $PIDFILE 2> /dev/null
	fi
	
	#$START_BRIDGE $BR_INTERFACE $BR_LAN1_INTERFACE $WLAN_INTERFACE $BR_LAN2_INTERFACE
	#$START_BRIDGE $BR_INTERFACE $BR_LAN1_INTERFACE $WLAN_INTERFACE_REPEATER
	$START_BRIDGE $BR_INTERFACE $BR_LAN1_INTERFACE $WLAN_INTERFACE_REPEATER eth1
	# Delete DHCP server process
	PIDFILE=/var/run/udhcpd.pid

	if [ -f $PIDFILE ] ; then
		PID=`cat $PIDFILE`
		if [ "$PID" != "0" ]; then
			kill -9 $PID 2> /dev/null
	   	fi
		rm -f $PIDFILE 2> /dev/null
	fi

	if [ "$DHCP" = '2' ]; then
		sleep 1
		$START_DHCP_SERVER $BR_INTERFACE ap
	fi

	if [ "$DHCP" = '0' ] || [ "$DHCP" = '2' ]; then		#Erwin
		$START_WLAN_APP start $WLAN_INTERFACE $BR_INTERFACE
	fi
fi

/bin/zebra.sh &
/bin/ripd.sh &
/bin/snmpd.sh &

#if [ "$DHCP" = '0' ] || [ "$DHCP" = '2' ]; then
#	$START_IAPP_8021X $BR_INTERFACE
#fi

echo "********** run Diagd **********"
#killall diagd 2> /dev/null

#/bin/diagd -d

echo "********** run GaTest **********"


#if [ "$MODE" = "-D_edimax_" ] || [ "$MODE" = "-D_general_" ]; then
	echo "=================Enable WSC_UPNP==================="
	#remove old
#	line=0
#	ps -A | grep wscd > /var/tmpfile
#	line=`cat /var/tmpfile | wc -l`
#	num=1
#	while [ $num -le $line ];
#	do
#		pat0=` head -n $num /var/tmpfile | tail -n 1`
#		pat1=`echo $pat0 | cut -f2 -dS | tr -s [" "] | cut -f2 -d " "`
#
#		if [ "$pat1" = 'wscd' ]; then
#				pat1=`echo $pat0 | cut -f1 -dS | tr -s [" "] `
#				pat2=`echo $pat1 | cut -f1 -d " "`
#				echo "kill $pat2"
#				kill -9 $pat2
#				
#		fi
#		num=`expr $num + 1`
#	done
#############ADSL################
if [ "$MODEL" = "-D_7264Wn_" ]; then
	/bin/adsl-command.sh 1;
	sleep 3
fi
#####################################

	
echo "=================Enable WSC_UPNP==================="
	
	
	if [ "$WPS_ENABLE" = "1" ];then
		route add -net 239.0.0.0 netmask 255.0.0.0 br0
		killall wscd  1>/dev/null 2>&1
   killall -9 wscd  1>/dev/null 2>&1
		wscd -w /etc/xml -m 1 -d 3 &	
	else
		route del -net 239.0.0.0 netmask 255.0.0.0 br0
		killall wscd  1>/dev/null 2>&1
   killall -9 wscd  1>/dev/null 2>&1
	fi	


echo "=================Enable LLTD==================="
 /bin/lld2d br0
 
echo "=================END LLTD==================="

if [ "$PRESS" = "0" ]; then 
echo "=================Enable SNTP (AP Mode)==================="
/bin/sntp.sh &
echo "=================END SNTP==================="
fi


killall agent 2> /dev/null
rm /tmp/agentenabledflag
/bin/agent&

killall cleanlog.sh 2> /dev/null
/bin/cleanlog.sh &
if [ "$GATEWAY" = 'true' ]; then
	echo 1 > /proc/sys/net/ipv4/ip_forward
	
	rmmod fv_fastnat 2> /dev/null 

	WAN=eth1        
                
	#PPoE           
	if [ "$WAN_MODE" = "2" ]; then
	    WAN=ppp0 
	fi              
	                
	#PPtP           
	if [ "$WAN_MODE" = "3" ]; then
    	    WAN=ppp0
	fi          
		      
	#L2TP
	if [ "$WAN_MODE" = "6" ]; then
    	    WAN=ppp0
	fi          
	
	if [ "$NAT_ENABLE" = "1" ]; then
		iptables -t nat -A POSTROUTING -o $WAN -j MASQUERADE
	fi

	if [ "$WAN" = "eth1" ];then

		if [ "$FAST_NAT_ENABLE" = "1" ]; then		
			insmod /lib/modules/2.6.17.3-gcc-4.1-FV13XX.299/fvt13xx/fv_fastnat.ko 
		fi
	fi	
#	/bin/dnrd -s 168.95.1.1
fi
if [ "$RSER_ENABLED" = "1" ] || [ "$DOT1X_MODE" = "1" ]; then
        Radiusd.sh stop
        Radiusd.sh start
else
        Radiusd.sh stop
fi
if [ "$MODE" = "-D_general_" ]; then
		vlanpassthrough.sh
fi
ioctl eth0 3 31
