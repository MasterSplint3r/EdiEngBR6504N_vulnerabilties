#!/bin/sh

. /var/flash.inc


CONF_FILE=/etc/l2tp/l2tp.conf
PPP_L2TP=/etc/ppp/options.l2tpd

L2TP_LOG=/var/log/l2tp.err

echo "global" > $CONF_FILE
echo "load-handler \"/bin/handlers/sync-pppd.so\"" >> $CONF_FILE
echo "load-handler \"/bin/handlers/cmd.so\"" >> $CONF_FILE
echo "listen-port 1701" >> $CONF_FILE
echo "section sync-pppd" >> $CONF_FILE
echo "lac-pppd-opts \"file /etc/ppp/options.l2tpd\"" >> $CONF_FILE
echo "section peer" >> $CONF_FILE
#echo "peer $L2TP_GATEWAY" >> $CONF_FILE
echo "peer $1" >> $CONF_FILE
echo "port 1701" >> $CONF_FILE
echo "lac-handler sync-pppd" >> $CONF_FILE
echo "retain-tunnel 1" >> $CONF_FILE
echo "section cmd" >> $CONF_FILE

