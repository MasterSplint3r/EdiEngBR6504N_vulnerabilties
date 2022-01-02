#!/bin/sh
#
# script file to start bridge
#
# Usage: bridge.sh br_interface lan1_interface wlan_interface[1]..wlan_interface[N]
#

if [ $# -lt 3 ]; then echo "Usage: $0 br_interface lan1_interface wlan_interface lan2_interface...";  exit 1 ; fi

GETMIB="flash get"
BR_UTIL=brctl
SET_IP=fixedip.sh
START_DHCP_CLIENT=dhcpc.sh
IFCONFIG=ifconfig
WLAN_PREFIX=ra0
LAN_PREFIX=eth
MAX_WDS_NUM=5

#include file
. /var/flash.inc

if [ "$3" != "null" ]; then	
	# shutdown LAN interface (ethernt, wlan, WDS, bridge)
	$IFCONFIG $2 down
	for ARG in $* ; do
		INTERFACE=`echo $ARG | cut -b -4`
		if [ $INTERFACE = $WLAN_PREFIX ]; then	
#			$IFCONFIG $ARG down
			num=1
			while [ $num -lt $MAX_WDS_NUM ]
			do
				$IFCONFIG ra$num down
				num=`expr $num + 1`
			done			
		fi	
	done

	$IFCONFIG $1 down
	$BR_UTIL delbr $1

	# Enable LAN interface (Ethernet, wlan, WDS, bridge)
	echo 'Setup bridge...'
	$BR_UTIL addbr $1

	if [ "$STP_ENABLED" = '0' ]; then
		$BR_UTIL setfd $1 0
		$BR_UTIL stp $1 0
	else
		$BR_UTIL setfd $1 4
		$BR_UTIL stp $1 1
	fi

	#Add lan port to bridge interface
	for ARG in $* ; do
		INTERFACE=`echo $ARG | cut -b -3`
		if [ $INTERFACE = $LAN_PREFIX ]; then	
			$BR_UTIL addif $1 $ARG
			$SET_IP $ARG  0.0.0.0
		fi	
	done
	
	for ARG in $* ; do
		INTERFACE=`echo $ARG | cut -b -4`
		if [ $INTERFACE = $WLAN_PREFIX ]; then
			if [ "$WLAN_DISABLED" = 0 ]; then
				# if opmode is wireless isp, don't add wlan0 to bridge
				if [ "$OP_MODE" != '1' ] || [ $ARG != "wlan$WISP_WAN_ID" ] ;then
					$BR_UTIL addif $1 $ARG		
					$SET_IP $ARG 0.0.0.0
				else
					$IFCONFIG $ARG up
				fi		
				if [ $AP_MODE = '3' -o $AP_MODE = '4' -o $AP_MODE = '5' ]; then
					num=0
					addr_num=1
					while [ $num -lt 4 ]
					do
						eval "WL_LINKMAC="\$WL_LINKMAC$addr_num""
						if [ "$WL_LINKMAC" != "000000000000" ]; then
							$BR_UTIL addif $1 wds$num
							$SET_IP wds$num 0.0.0.0

							addr_num=`expr $addr_num + 1`
						fi
						if [ $AP_MODE = '3' ]; then
							num=`expr $num + 6`
						else
							num=`expr $num + 1`
						fi
					done
				fi
			fi
		fi
	done

	$SET_IP $1 0.0.0.0
fi

# Set fixed IP or start DHCP client
eval `$GETMIB DHCP`
if [ "$DHCP" = '0' -o "$DHCP" = '2' ]; then
	$SET_IP $1 $IP_ADDR $SUBNET_MASK $DEFAULT_GATEWAY
elif [ "$DHCP" = '1' ]; then
  {
  	eval `$GETMIB STP_ENABLED`
	if [ "$STP_ENABLED" = '1' ]; then
		echo 'waiting for bridge initialization...'
		sleep 30
	fi
	$START_DHCP_CLIENT $1 no
  }&
fi
