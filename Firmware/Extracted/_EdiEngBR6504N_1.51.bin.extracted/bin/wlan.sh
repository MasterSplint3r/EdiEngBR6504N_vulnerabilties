#!/bin/sh
#
# script file to start WLAN
#
if [ $# -lt 1 ]; then echo "Usage: $0 ra_interface";  exit 1 ; fi

#GETMIB="flash get"
SET_WLAN="iwpriv $1"
SET_WLAN_PARAM="$SET_WLAN set"
IFCONFIG=ifconfig
START_WLAN_APP=wlanapp.sh

DEF_CFG_FILE=/etc/Wireless/RT2860AP/RT2860AP-def.dat
CFG_FILE=/etc/Wireless/RT2860AP/RT2860AP.dat

MAX_WDS_NUM=6
#MODE=`cat /web/mode`
. /web/mode


ConfigType=`flash all | grep WPS_CONFIG_TYPE | cut -d= -f 2`
MACADDR=`flash all | grep -i HW_NIC0_ADDR | cut -d= -f 2`

if [ "$MODE" = "-D_jensen_" ] && [ "$ConfigType" = "0" ]; then
	echo "############AUTO_WPA Start########################"
#	rmmod rt2860ap	2> /dev/null
#	sleep 1
#	insmod /bin/rt2860ap.ko 
#	$IFCONFIG $1 up
#	ifconfig br0 
#ifconfig
	AutoWPA=`AutoWPA $MACADDR`
	echo "Auto WPA = $AutoWPA"
	flash set WLAN_WPA_CIPHER_SUITE 1;
	flash set WPA2_CIPHER_SUITE 0;
	flash set WLAN_PSK_FORMAT 0
	flash set WLAN_WPA_PSK "$AutoWPA"
	flash all2 > /var/flash.inc

# $IFCONFIG $1 down
#	rmmod rt2860ap	2> /dev/null
# sleep 1
	
	echo "############AUTO_WPA END########################"
fi





#include file
. /var/flash.inc

cat $DEF_CFG_FILE > $CFG_FILE

## Disable WLAN MAC driver and shutdown interface first ##
#$IFCONFIG $1 down

## kill wlan application daemon ##
#$START_WLAN_APP kill $1

if [ "$WLAN_DISABLED" = '1' ] && [ "$2" != '1' ]; then
	echo "LED OFF" > /dev/WLAN_LED0
	exit 1
fi

echo "LED BLINK RANDOM" > /dev/WLAN_LED0

echo "CountryRegion=5" >> $CFG_FILE  	# Set Channel 1-14, let Webs to decide

# set RF parameters

echo "BeaconPeriod=$BEACON_INTERVAL" >> $CFG_FILE

echo "Channel=$CHANNEL" >> $CFG_FILE

if [ "$CHANNEL" -gt "4" ]; then
	echo "HT_EXTCHA=0" >> $CFG_FILE
else
	echo "HT_EXTCHA=1" >> $CFG_FILE
fi

echo "TxRate=$FIX_RATE" >> $CFG_FILE

if [ "$WLAN_N_FIXRTAE" = '0' ]; then
	echo "HT_MCS=33" >> $CFG_FILE
else
	nTxRate=`expr $WLAN_N_FIXRTAE - 1`
	echo "HT_MCS=$nTxRate" >> $CFG_FILE
fi


if [ "$MODE" = "-D_edimax20bw_" ]; then
	echo "HT_BW=0" >> $CFG_FILE

else

	if [ "$WLAN_N_CHAN_WIDTH" = '0' ]; then
		echo "HT_BW=1" >> $CFG_FILE
	else
		echo "HT_BW=0" >> $CFG_FILE
	fi

fi




#if [ "$RATE_ADAPTIVE_ENABLED" = '0' ]; then
#	echo autorate=0
#	echo fixrate=$FIX_RATE
#else
#	echo autorate=1
#fi

echo "RTSThreshold=$RTS_THRESHOLD" >> $CFG_FILE

echo "FragThreshold=$FRAG_THRESHOLD" >> $CFG_FILE

#echo expired_time=$INACTIVITY_TIME

echo "TxPreamble=$PREAMBLE_TYPE" >> $CFG_FILE

echo "HideSSID=$HIDDEN_SSID" >> $CFG_FILE

echo "DtimPeriod=$DTIM_PERIOD" >> $CFG_FILE

#set wireless MAC access control

if [ "$WLAN_MACAC_ENABLED" != '0' ]; then
	if [ "$WLAN_MACAC_NUM" != 0 ]; then
		echo "AccessPolicy0=1" >> $CFG_FILE
		flash aclList >> $CFG_FILE
	else
		echo "AccessPolicy0=0" >> $CFG_FILE
	fi
else
	echo "AccessPolicy0=0" >> $CFG_FILE
fi

if [ "$AP_MODE" != '3' ] && [ "$AP_MODE" != '4' ]; then
	case "$SECURITY_MODE" in
		"0")    #Disable
       		echo "AuthMode=OPEN" >> $CFG_FILE
       		echo "EncrypType=NONE" >> $CFG_FILE
           	;;
   	
		"1")    #WEP
	        echo "AuthMode=WEPAUTO" >> $CFG_FILE
        	echo "EncrypType=WEP" >> $CFG_FILE

	        if [ $WEP_KEY_TYPE = 0 ]; then
       	        KEY_TYPE=1;
	        else
                KEY_TYPE=0;
	        fi
	
			echo "Key1Type=0" >> $CFG_FILE     		# 0 hex, 1 ascii
			echo "Key2Type=0" >> $CFG_FILE
			echo "Key3Type=0" >> $CFG_FILE
			echo "Key4Type=0" >> $CFG_FILE
		
			DefKey=`expr $WEP_DEFAULT_KEY + 1`
			echo "DefaultKeyID=$DefKey" >> $CFG_FILE
						
			if [ "$WEP" = '1' ]; then
				echo "Key1Str=$WEP64_KEY1" >> $CFG_FILE
				echo "Key2Str=$WEP64_KEY2" >> $CFG_FILE
				echo "Key3Str=$WEP64_KEY3" >> $CFG_FILE
				echo "Key4Str=$WEP64_KEY4" >> $CFG_FILE
			else
				echo "Key1Str=$WEP128_KEY1" >> $CFG_FILE
				echo "Key2Str=$WEP128_KEY2" >> $CFG_FILE
				echo "Key3Str=$WEP128_KEY3" >> $CFG_FILE
				echo "Key4Str=$WEP128_KEY4" >> $CFG_FILE
			fi
			;;

		"2")    #WPA pre shared key
     		if [ $WLAN_WPA_CIPHER_SUITE = 1 ] && [ $WPA2_CIPHER_SUITE = 2 ]; then	# Mixed
				echo "AuthMode=WPAPSKWPA2PSK" >> $CFG_FILE
	            echo "EncrypType=TKIPAES" >> $CFG_FILE
				echo "PreAuth=0" >> $CFG_FILE
			elif [ $WPA2_CIPHER_SUITE = 2 ]; then									# AES 			
				echo "AuthMode=WPA2PSK" >> $CFG_FILE
	            echo "EncrypType=AES" >> $CFG_FILE	
				echo "PreAuth=1" >> $CFG_FILE
			elif [ $WLAN_WPA_CIPHER_SUITE = 1 ]; then								# TKIP
	        	echo "AuthMode=WPAPSK" >> $CFG_FILE
	        	echo "EncrypType=TKIP" >> $CFG_FILE
				echo "PreAuth=0" >> $CFG_FILE
	       	fi
                
			echo "WPAPSK=$WLAN_WPA_PSK" >> $CFG_FILE
	        echo "DefaultKeyID=2" >> $CFG_FILE
	        echo "RekeyInterval=$WLAN_WPA_GROUP_REKEY_TIME" >> $CFG_FILE
	        ;;
               
		"3")    #WPA RADIUS
	        echo "DefaultKeyID=2" >> $CFG_FILE

	     	if [ $WLAN_WPA_CIPHER_SUITE = 1 ] && [ $WPA2_CIPHER_SUITE = 2 ]; then	# Mixed
				echo "AuthMode=WPA1WPA2" >> $CFG_FILE
	            echo "EncrypType=TKIPAES" >> $CFG_FILE
				echo "PreAuth=0" >> $CFG_FILE
			elif [ $WPA2_CIPHER_SUITE = 2 ]; then									# AES 			
				echo "AuthMode=WPA2" >> $CFG_FILE
	            echo "EncrypType=AES" >> $CFG_FILE	
				echo "PreAuth=1" >> $CFG_FILE
			elif [ $WLAN_WPA_CIPHER_SUITE = 1 ]; then								# TKIP
	        	echo "AuthMode=WPA" >> $CFG_FILE
	        	echo "EncrypType=TKIP" >> $CFG_FILE
				echo "PreAuth=0" >> $CFG_FILE
	       	fi
			;;
	esac


	# Set 802.1x flag ##
	ENABLE_1X=0
	if [ $WLAN_ENCRYPT -lt 2 ]; then
		if [ "$WLAN_ENABLE_1X" != 0 ] || [ "$MAC_AUTH_ENABLED" != 0 ]; then
			ENABLE_1X=1
		fi
	else
		ENABLE_1X=1
	fi
if [ "$AP_MODE" = '3' ] && [ "$AP_MODE" = '4' ] && [ "$AP_MODE" = '5' ]; then
	ENABLE_1X=0
fi

	if [ $ENABLE_1X = 1 ]; then
		if [ $SECURITY_MODE = 0 ] || [ $SECURITY_MODE = 1 ] ;then
			echo IEEE8021X=1 >> $CFG_FILE		# only need enable while Non or WEP Radius mode
		else
			echo IEEE8021X=0 >> $CFG_FILE
  	fi


  	echo "****************Use External RADIUS******************"
		echo RADIUS_Server=$RS_IP >> $CFG_FILE
		echo RADIUS_Key=$RS_PASSWORD >> $CFG_FILE
		echo RADIUS_Port=$RS_PORT >> $CFG_FILE
		echo own_ip_addr=$IP_ADDR >> $CFG_FILE
		echo session_timeout_interval=0 >> $CFG_FILE # 5 min
		echo idle_timeout_interval=0 >> $CFG_FILE 
	
	else
		echo IEEE8021X=0 >> $CFG_FILE
	fi
fi

# set WDS

if [ "$AP_MODE" = '3' ] || [ "$AP_MODE" = '4' ]; then
	# WDS only
	echo "WdsEnable=2" >> $CFG_FILE
	echo "WdsPhyMode=HTMIX" >> $CFG_FILE
elif [ "$AP_MODE" = '5' ]; then
	# AP+WDS
	echo "WdsEnable=1" >> $CFG_FILE
	echo "WdsPhyMode=HTMIX" >> $CFG_FILE
else
    echo "WdsEnable=0" >> $CFG_FILE
fi

if [ "$AP_MODE" = '3' -o "$AP_MODE" = '4' -o "$AP_MODE" = '5' ]; then
	flash wdsList >> $CFG_FILE
fi


if [ "$AP_MODE" = 3 -o "$AP_MODE" = 4 -o "$AP_MODE" = 5 ]; then
	if [ "$AP_MODE" = '3' ] || [ "$AP_MODE" = '4' ]; then
		case "$WLAN_WDS_ENCRYPT" in 	# Based on WDS sercurity to set AP security in this case
			"0")    #Disable
       			echo "AuthMode=OPEN" >> $CFG_FILE
           		;;
   	
			"1")    #WEP
	        	echo "AuthMode=WEPAUTO" >> $CFG_FILE
        		echo "EncrypType=WEP" >> $CFG_FILE

	        	if [ "$WEP_KEY_TYPE" = "0" ]; then
       	        	KEY_TYPE=1;
	        	else
                	KEY_TYPE=0;
	        	fi
	
				echo "Key1Type=0" >> $CFG_FILE     		# 0 hex, 1 ascii
				echo "Key2Type=0" >> $CFG_FILE
				echo "Key3Type=0" >> $CFG_FILE
				echo "Key4Type=0" >> $CFG_FILE
		
				DefKey=`expr $WEP_DEFAULT_KEY + 1`
				echo "DefaultKeyID=$DefKey" >> $CFG_FILE
						
				if [ "$WEP" = '1' ]; then
					echo "Key1Str=$WEP64_KEY1" >> $CFG_FILE
					echo "Key2Str=$WEP64_KEY2" >> $CFG_FILE
					echo "Key3Str=$WEP64_KEY3" >> $CFG_FILE
					echo "Key4Str=$WEP64_KEY4" >> $CFG_FILE
				else
					echo "Key1Str=$WEP128_KEY1" >> $CFG_FILE
					echo "Key2Str=$WEP128_KEY2" >> $CFG_FILE
					echo "Key3Str=$WEP128_KEY3" >> $CFG_FILE
					echo "Key4Str=$WEP128_KEY4" >> $CFG_FILE
				fi
				;;

			"2")    #WPA pre shared key
	     		if [ "$WLAN_WPA_CIPHER_SUITE" = "1" ] && [ $WPA2_CIPHER_SUITE = 2 ]; then	# Mixed
					echo "AuthMode=WPAPSKWPA2PSK" >> $CFG_FILE
		            echo "EncrypType=TKIPAES" >> $CFG_FILE
				elif [ "$WPA2_CIPHER_SUITE" = "2" ]; then									# AES 			
					echo "AuthMode=WPA2PSK" >> $CFG_FILE
		            echo "EncrypType=AES" >> $CFG_FILE	
				elif [ "$WLAN_WPA_CIPHER_SUITE" = "1" ]; then								# TKIP
		        	echo "AuthMode=WPAPSK" >> $CFG_FILE
		        	echo "EncrypType=TKIP" >> $CFG_FILE
		       	fi
                
				echo "WPAPSK=$WLAN_WPA_PSK" >> $CFG_FILE
		        echo "DefaultKeyID=2" >> $CFG_FILE
		        echo "RekeyInterval=$WLAN_WPA_GROUP_REKEY_TIME" >> $CFG_FILE
		        ;;
		esac
		# set WDS security
		if [ "$WLAN_WDS_ENCRYPT" = '0' ]; then
			echo "WdsEncrypType=NONE" >> $CFG_FILE
		elif [ "$WLAN_WDS_ENCRYPT" = '1' ]; then
			echo "WdsEncrypType=WEP" >> $CFG_FILE
		elif [ "$WLAN_WDS_ENCRYPT" = '2' ]; then
			if [ "$WLAN_WDS_WPA_CIPHER_SUITE" = '1' ]; then
				echo "WdsEncrypType=TKIP" >> $CFG_FILE
			else 
				echo "WdsEncrypType=AES" >> $CFG_FILE
			fi
			
			if [ "$WLAN_WDS_WPA_PSK" = "" ]; then
				echo "WdsKey=$WLAN_WPA_PSK" >> $CFG_FILE
			else
				echo "WdsKey=$WLAN_WDS_WPA_PSK" >> $CFG_FILE
			fi
		fi
	else	# AP_MODE = 5 , WDS security must based on AP
		if [ "$SECURITY_MODE" = '0' ]; then
			echo "WdsEncrypType=NONE" >> $CFG_FILE
		elif [ "$SECURITY_MODE" = '1' ]; then
			echo "WdsEncrypType=WEP" >> $CFG_FILE
		else
			if [ "$WLAN_WDS_WPA_CIPHER_SUITE" = '1' ]; then
				echo "WdsEncrypType=TKIP" >> $CFG_FILE
			else 
				echo "WdsEncrypType=AES" >> $CFG_FILE
			fi

			if [ "$WLAN_WDS_WPA_PSK" = "" ]; then
				echo "WdsKey=$WLAN_WPA_PSK" >> $CFG_FILE
			else
				echo "WdsKey=$WLAN_WDS_WPA_PSK" >> $CFG_FILE
			fi
		fi
	fi
fi


#set WPS
if [ "$MODE" = "-D_jensen_" ]; then
		if [ "$WPS_PROXY_ENABLE" = "1" ];then		
		
				echo "WscConfMode=2">> $CFG_FILE
		else
		
				echo "WscConfMode=0">> $CFG_FILE
		fi	

else
	echo "WscConfMode=$WPS_CONFIG_MODE">> $CFG_FILE
fi


if [ "$MODE" != "-D_jensen_" ]; then
	if [ "$WPS_CONFIG_TYPE"	= "0"	]; then
	echo "WscConfStatus=1">> $CFG_FILE
	else
	echo "WscConfStatus=2">> $CFG_FILE
	fi
else
	echo "WscConfStatus=2">> $CFG_FILE
fi

#set NoForWarding

if [ "$WLAN_NOFORWARD" = "1" ]; then	
echo "NoForwarding=1">> $CFG_FILE
else
echo "NoForwarding=0">> $CFG_FILE
fi


# enable/disable the notification for IAPP
#if [ "$IAPP_DISABLED" = 0 ]; then
#	echo "" >> $CFG_FILE
#else
#	echo "" >> $CFG_FILE
#fi

#set band
if [ "$BAND" = "1" ]; then
	echo "BasicRate=15" >> $CFG_FILE
	echo "WirelessMode=1" >> $CFG_FILE	# b
	
#802.11 b
echo "BSSTxop=0;0;188;102" >> $CFG_FILE
echo "APTxop=0;0;188;102" >> $CFG_FILE
elif [ "$BAND" = "2" ]; then
	echo "BasicRate=15" >> $CFG_FILE
	echo "WirelessMode=6" >> $CFG_FILE	# n
	
#802.11 a/g
echo "BSSTxop=0;0;94;47" >> $CFG_FILE
echo "APTxop=0;0;94;47" >> $CFG_FILE
elif [ "$BAND" = "3" ]; then
	echo "BasicRate=15" >> $CFG_FILE
	echo "WirelessMode=0" >> $CFG_FILE	# b/g mix
	
#802.11 a/g
echo "BSSTxop=0;0;94;47" >> $CFG_FILE
echo "APTxop=0;0;94;47" >> $CFG_FILE
elif [ "$BAND" = "4" ]; then
	echo "BasicRate=351" >> $CFG_FILE
	echo "WirelessMode=4" >> $CFG_FILE	# g 
	
#802.11 a/g
echo "BSSTxop=0;0;94;47" >> $CFG_FILE
echo "APTxop=0;0;94;47" >> $CFG_FILE
elif [ "$BAND" = "5" ]; then
	echo "BasicRate=15" >> $CFG_FILE
	echo "WirelessMode=9" >> $CFG_FILE	# b/g/n mix
	
#802.11 a/g
echo "BSSTxop=0;0;94;47" >> $CFG_FILE
echo "APTxop=0;0;94;47" >> $CFG_FILE
fi 


#set nat2.5 disable when client and mac clone is set
#if [ "$MACCLONE_ENABLED" = '1' ] && [ "$AP_MODE" = '1' -o "$AP_MODE" = '2' ]; then
#	echo nat25_disable=1
#	echo macclone_enable=1
#else
#	echo nat25_disable=0
#	echo macclone_enable=0
#fi
# set nat2.5 disable and macclone disable when wireless isp mode
#if [ "$OP_MODE" = '2' ] ;then
#	echo nat25_disable=1
#	echo macclone_enable=0
#fi

#set 11g protection mode
echo "BGProtection=$WLAN_CTS" >> $CFG_FILE


if [ "$WLAN_TX_POWER" = "0" ]; then
	echo "TxPower=100" >> $CFG_FILE
else
	echo "TxPower=$WLAN_TX_POWER" >> $CFG_FILE
fi
	

#if [ "$WLAN_TURBO" = "0" ]; then
#	if [ "$WLAN_WMM" = "0" ]; then
#		echo "TxBurst=1" >> $CFG_FILE
#	else
#		echo "TxBurst=0" >> $CFG_FILE		
#	fi
#	echo "PktAggregate=1" >> $CFG_FILE
#	echo "TurboRate=1" >> $CFG_FILE
#else



	echo "TxBurst=0" >> $CFG_FILE
	echo "PktAggregate=0" >> $CFG_FILE
	echo "TurboRate=0" >> $CFG_FILE
#fi

if [ "$WLAN_WMM" = "0" ]; then
	echo "WmmCapable=0" >> $CFG_FILE
#	echo "HT_AutoBA=1" >> $CFG_FILE
else
	echo "WmmCapable=1" >> $CFG_FILE
#	echo "HT_AutoBA=0" >> $CFG_FILE
fi
#for WIFI TES
echo "WiFiTest=$WIFI_TEST" >> $CFG_FILE

if [ "$MODE" = "-D_pci_" ]; then
	echo "CarrierDetect=1" >> $CFG_FILE
fi


echo "SSID=$SSID" >> $CFG_FILE			# Ralink use this to start settings

ifconfig ra0 down 2> /dev/null
ifconfig wds0 down 2> /dev/null
ifconfig wds1 down 2> /dev/null
ifconfig wds2 down 2> /dev/null
ifconfig wds3 down 2> /dev/null

brctl delif br0 ra0 2> /dev/null
brctl delif br0 wds0 2> /dev/null
brctl delif br0 wds1 2> /dev/null
brctl delif br0 wds2 2> /dev/null
brctl delif br0 wds3 2> /dev/null




rmmod rt2860ap 2> /dev/null
sleep 1
insmod /bin/rt2860ap.ko 


wlan_exist=`/sbin/ifconfig -a | /bin/grep "ra0"`

if [ "$wlan_exist" = "" ]; then
    echo "LED OFF" > /dev/WLAN_LED0
fi

if [ "$WLAN_MAC_ADDR" = "000000000000" ]; then
	WLAN_MAC_ADDR=$HW_WLAN_ADDR
fi

$IFCONFIG $1 up

$SET_WLAN_PARAM Debug=0
ifconfig ra0 | grep "HWaddr" > /var/wlanTmp
HW_MAC=`cut -f 12 -d" " /var/wlanTmp`
#flash setWlanMAC $HW_MAC

#CountryDomain=`iwpriv ra0 e2p 24 |  cut -s -f 2 -d"]"  | cut -f2 -d":"`

#if [ "$CountryDomain" != "0xFF01 " ]; then
#	iwpriv ra0 e2p 24=ff01
#fi



if [ "$AP_MODE" = '3' -o "$AP_MODE" = '4' -o "$AP_MODE" = '5' ]; then
	num=0
	num1=1;
	while [ $num -le 3 ]                            # max 6 for rtl, 4 for ralink
        do
		eval "WL_LINKMAC="\$WL_LINKMAC$num1""
		if [ "$WL_LINKMAC" != "000000000000" ]; then
                	#echo wds_add=$WL_LINKMAC
			$IFCONFIG wds$num up
		fi
   num1=`expr $num1 + 1`
		if [ "$AP_MODE" = '3' ]; then   #exit
			num=`expr $num + 4`                     # max 6 for rtl, 4 for ralink
                else
			num=`expr $num + 1`
		fi
	done
fi

MAC1=`iwpriv ra0 e2p 4 | grep :0x | cut -f 2 -d : | cut -b 5-6 | tr [A-Z] [a-z]`
MAC2=`iwpriv ra0 e2p 4 | grep :0x | cut -f 2 -d : | cut -b 3-4 | tr [A-Z] [a-z]`

MAC3=`iwpriv ra0 e2p 6 | grep :0x | cut -f 2 -d : | cut -b 5-6 | tr [A-Z] [a-z]`
MAC4=`iwpriv ra0 e2p 6 | grep :0x | cut -f 2 -d : | cut -b 3-4 | tr [A-Z] [a-z]`

MAC5=`iwpriv ra0 e2p 8 | grep :0x | cut -f 2 -d : | cut -b 5-6 | tr [A-Z] [a-z]`
MAC6=`iwpriv ra0 e2p 8 | grep :0x | cut -f 2 -d : | cut -b 3-4 | tr [A-Z] [a-z]`
MAC_ALL=$MAC1$MAC2$MAC3$MAC4$MAC5$MAC6

if [ "$MAC_ALL" != "$HW_WLAN_ADDR" ]; then
	echo " Write Wlan MAC to EEPROM"
	
	FMAC1=`flash all | grep -i HW_WLAN_ADD | cut -f 2 -d=| cut -b 0-2`
	FMAC2=`flash all | grep -i HW_WLAN_ADD | cut -f 2 -d=| cut -b 3-4`
	
	FMAC3=`flash all | grep -i HW_WLAN_ADD | cut -f 2 -d=| cut -b 5-6`
	FMAC4=`flash all | grep -i HW_WLAN_ADD | cut -f 2 -d=| cut -b 7-8`
	
	FMAC5=`flash all | grep -i HW_WLAN_ADD | cut -f 2 -d=| cut -b 9-10`
	FMAC6=`flash all | grep -i HW_WLAN_ADD | cut -f 2 -d=| cut -b 11-12`
	iwpriv ra0  e2p 4=$FMAC2$FMAC1
	iwpriv ra0  e2p 6=$FMAC4$FMAC3
	iwpriv ra0  e2p 8=$FMAC6$FMAC5
	
	wlan.sh ra0
	
fi
