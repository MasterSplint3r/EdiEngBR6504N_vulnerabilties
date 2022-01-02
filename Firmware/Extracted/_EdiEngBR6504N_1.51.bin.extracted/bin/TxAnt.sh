#!/bin/sh
#
# script file to start WLAN
#

ORG_CFG_FILE=/etc/Wireless/RT2860AP/RT2860AP-org.dat
CFG_FILE=/etc/Wireless/RT2860AP/RT2860AP.dat

echo Default > $CFG_FILE 
echo TxAntenna=$1 >> $CFG_FILE 
echo HT_MCS=$2 >> $CFG_FILE
cat $ORG_CFG_FILE >> $CFG_FILE

ifconfig ra0 down
rmmod rt2860ap
sleep 5

insmod /bin/rt2860ap.ko
sleep 3

ifconfig ra0 up
brctl addif br0 ra0

