#!/bin/sh

#ifconfig eth1 down
#ifconfig wlan0 down
#ifconfig br0 down
#brctl delif br0 eth1
#brctl delif br0 wlan0
#brctl delbr br0

#brctl addbr br0
#brctl addif br0 eth1
#ifconfig eth1 0.0.0.0
#ifconfig wlan0 0.0.0.0
stawpa.sh
#/bin/wpa_supplicant -B -iwlan0sta -cwpa.conf -Dipn2220
#/bin/wpa_supplicant -B -iwlan0sta -c/wpa.conf -Dvenus &
/bin/wpa_supplicant -B -iwlan0sta -c/wpa.conf -Dvenus &
#sleep 5
#brctl addif br0 wlan0
#fixedip.sh br0 $1 $2 $3

