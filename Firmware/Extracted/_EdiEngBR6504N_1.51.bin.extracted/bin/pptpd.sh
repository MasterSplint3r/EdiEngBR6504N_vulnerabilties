#!/bin/sh

#include file
. /var/flash.inc

CFG_FILE=/etc/pptpd.conf
PPPD_OPTION_FILE=/etc/ppp/options.pptpdvpn
PPPD_PATH=/bin/pppd
PPTPD_PID=/var/run/pptpd.pid


write_config() {
# wirte pptpd.conf

echo "" > $CFG_FILE
echo "ppp $PPPD_PATH" >> $CFG_FILE
echo "option $PPPD_OPTION_FILE"  >> $CFG_FILE
echo "debug" >> $CFG_FILE
echo "logwtmp" >> $CFG_FILE
echo "localip $PPTPD_IP" >> $CFG_FILE
echo "remoteip $PPTPD_IP_POOL1-$PPTPD_IP_POOL2" >> $CFG_FILE

# wirte options.pptpd

echo "" > $PPPD_OPTION_FILE

echo "name pptpd" >> $PPPD_OPTION_FILE
echo "ms-dns 168.95.1.1" >> $PPPD_OPTION_FILE
echo "proxyarp" >> $PPPD_OPTION_FILE
echo "debug" >> $PPPD_OPTION_FILE
echo "dump" >> $PPPD_OPTION_FILE
echo "lock" >> $PPPD_OPTION_FILE
echo "nobsdcomp" >> $PPPD_OPTION_FILE

# Authentication mode
case "$PPTPD_AUTH" in
	"0")
	echo "require-pap" >> $PPPD_OPTION_FILE
	;;
	"1")
	echo "require-chap" >> $PPPD_OPTION_FILE
	;;
	"2")
	echo "require-mschap" >> $PPPD_OPTION_FILE
	;;
	"3")
	echo "require-mschap-v2" >> $PPPD_OPTION_FILE
	;;
esac	
	
# MPPE enryption
if [ $PPTPD_MPPE -gt 0 ]; then 
  echo "require-mppe-128" >> $PPPD_OPTION_FILE
fi


}




if [ $PPTPD_ENABLED -eq 0 ]; then 
  
  echo "pptpd is running, shut down it "
    if [ -f $PPTPD_PID ] ; then
  kill `cat $PPTPD_PID`
  rm $PPTPD_PID
    fi
  
  exit
else 
     echo "start pptpd... "
    write_config
   pppd 0
    
fi






