#!/bin/sh
. /var/flash.inc
#SSID_MAC
echo "------------Set SSID_MAC-----------"

setSSID=`echo "$HW_NIC0_ADDR" | cut -b7-`
setSSID=`echo Topcom_"$setSSID"`
flash set SSID  $setSSID

echo "New SSID = $setSSID"
flash set IS_RESET_DEFAULT 1

flash all2 > /var/flash.inc