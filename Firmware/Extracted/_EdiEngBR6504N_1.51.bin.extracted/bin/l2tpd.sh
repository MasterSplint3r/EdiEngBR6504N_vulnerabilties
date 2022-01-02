#!/bin/sh

#include file
. /var/flash.inc

CFG_FILE=/etc/l2tp/l2tpd.conf
PPPD_OPTION_FILE=/etc/ppp/options.l2tpdvpn
L2TPD_PID=/var/run/l2tpdvpn.pid





write_config() {



# wirte l2tpd.conf

echo "" > $CFG_FILE
if [ $L2TPD_ENABLED -eq 0 ]; then 
  exit
fi

echo "[global]" >> $CFG_FILE
echo ";listen-addr = 192.168.5.167" >> $CFG_FILE
                                                                                                                                                                                   
echo "[lns default]" >> $CFG_FILE
echo "ip range = $L2TPD_IP_POOL1-$L2TPD_IP_POOL2" >> $CFG_FILE
echo "local ip = $L2TPD_IP" >> $CFG_FILE
echo "name = LinuxVPNserver" >> $CFG_FILE
echo "ppp debug = yes" >> $CFG_FILE
echo "pppoptfile = $PPPD_OPTION_FILE" >> $CFG_FILE
echo "length bit = yes" >> $CFG_FILE


# wirte options.l2tpd

echo "" > $PPPD_OPTION_FILE


echo "ipcp-accept-local" >> $PPPD_OPTION_FILE
echo "ipcp-accept-remote" >> $PPPD_OPTION_FILE
echo "ms-dns  168.95.1.1" >> $PPPD_OPTION_FILE
#echo "ms-wins 192.168.1.2" >> $PPPD_OPTION_FILE
echo "auth" >> $PPPD_OPTION_FILE
echo "crtscts" >> $PPPD_OPTION_FILE
echo "idle 1800" >> $PPPD_OPTION_FILE
echo "mtu 1400" >> $PPPD_OPTION_FILE
echo "mru 1400" >> $PPPD_OPTION_FILE
echo "nodefaultroute" >> $PPPD_OPTION_FILE
echo "debug" >> $PPPD_OPTION_FILE
echo "lock" >> $PPPD_OPTION_FILE
echo "proxyarp" >> $PPPD_OPTION_FILE
echo "connect-delay 5000" >> $PPPD_OPTION_FILE

# Authentication mode
case "$L2TPD_AUTH" in
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
	
}



if [ $L2TPD_ENABLED -eq 0 ]; then 
  
  echo "l2tpd is running, shut down it "
    if [ -f $L2TPD_PID ] ; then
  kill `cat $L2TPD_PID`
  rm $L2TPD_PID
    fi
  
  exit
else 
     echo "start l2tpd... "
    write_config
 
   l2tpdvpn 
   ps |  awk '{ if ($5=="l2tpdvpn") print $1  }' > $L2TPD_PID
    
fi





