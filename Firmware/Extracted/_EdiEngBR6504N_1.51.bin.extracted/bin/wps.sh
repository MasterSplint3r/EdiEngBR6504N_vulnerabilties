#!/bin/sh
#
# script file to start WPS
#
if [ $# -lt 1 ]; then echo "Usage: $0 WscMode PinCode";  exit 1 ; fi
. /var/flash.inc
#MODE=`cat /web/mode`
. /web/mode
	if [ "$1" != "3" ]; then
			echo "LED ON" > /dev/WLAN_LED0
			sleep 1
	fi
	
if [ "$MODE" = "-D_jensen_" ] && [ "$WPS_CONFIG_TYPE" = "0" ]; then

	echo "Enable Auto WPA"
	flash set SECURITY_MODE 2
	flash set WLAN_ENCRYPT 2
	flash set WPS_CONFIG_TYPE 1
	flash set WPS_DISPLAY_KEY 1
	flash all2 > /var/flash.inc
	wlan.sh ra0
	brctl addif br0 ra0
fi
echo "Start Wps!----->"
if [ "$MODE" = "-D_edimax_" ] || [ "$MODE" = "-D_simpedimax_" ] || [ "$MODE" = "-D_general_" ] || [ "$MODE" = "-D_telewell_" ] || [ "$MODE" = "-D_pci_" ] || [ "$MODE" = "-D_sitecom_" ]; then
	echo "Config Mode=7"
	iwpriv ra0 set WscConfMode=7
else
echo "Config Mode=$WPS_CONFIG_MODE"
iwpriv ra0 set WscConfMode=$WPS_CONFIG_MODE
fi

if [ "$WPS_ENABLE" = "0" ];then
	echo "WPS Function Disable!----->"
	iwpriv ra0 set WscConfMode=0
	echo "LED BLINK RANDOM" > /dev/WLAN_LED0
else

	if [ "$MODE" = "-D_jensen_" ]; then
			iwpriv ra0 set WscConfMode=7	
	fi

if [ "$MODE" != "-D_jensen_" ]; then
	echo iwpriv ra0 set WscConfStatus=$WPS_CONFIG_TYPE
	
	if [ "$WPS_CONFIG_TYPE" = "0" ]; then
		iwpriv ra0 set WscConfStatus=1
	else
		iwpriv ra0 set WscConfStatus=2
	fi
fi



if [ "$1" = "1" ]; then
	echo "Use ping----->"
	echo iwpriv ra0 set WscMode=$1
	iwpriv ra0 set WscMode=1
	if [ "$2" != "-1" ]; then
		echo iwpriv ra0 set WscPinCode=$2
		iwpriv ra0 set WscPinCode=$2	
	fi
elif [ "$1" = "2" ]; then
	echo "Use Push Button----->"
	echo iwpriv ra0 set WscMode=$1
	iwpriv ra0 set WscMode=2
fi

if [ "$1" != "3" ]; then
	echo "Trigger Wps AP to simple config with Wps client----->"
	echo iwpriv ra0 set WscGetConf=1
	iwpriv ra0 set WscGetConf=1
	echo "LED ON" > /dev/WLAN_LED0
	echo "start:	/bin/wpstool  CheckStatus $WPS_CONFIG_TYPE"
	killall wpstool
	/bin/wpstool  CheckStatus $WPS_CONFIG_TYPE
#When hardware button on.
echo "is hardware mode:$3"
	if [ "$3" != "0" ]; then
		killall webs
		/bin/webs &
		
	fi
	echo "LED BLINK RANDOM" > /dev/WLAN_LED0
fi



	if [ "$MODE" = "-D_jensen_" ]; then
	
		if [ "$WPS_PROXY_ENABLE" = "1" ];then		
		
			iwpriv ra0 set WscConfMode=2
		else
		
			iwpriv ra0 set WscConfMode=0
		fi

	fi

fi
