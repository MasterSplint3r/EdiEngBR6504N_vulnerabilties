#!/bin/sh

LOG_FILE=/var/run/syslog

rm -f $LOG_FILE 2> /dev/null

#include file
. /var/flash.inc

echo "" >> $LOG_FILE
echo System Log create time : `date +"%F %T"` >> $LOG_FILE
echo "" >> $LOG_FILE

echo "Firmware Version: `cat /etc/version`" >> $LOG_FILE
echo "" >> $LOG_FILE

echo "Compiler date: `cat /etc/compiler_date`" >> $LOG_FILE
echo "" >> $LOG_FILE

echo "------ Config setting -------" >> $LOG_FILE

grep -v PASSWORD /var/flash.inc >> $LOG_FILE

echo "-----------------------------" >> $LOG_FILE

if [ -f /proc/trigger_port_list ]; then
	echo "#############################" >> $LOG_FILE
	echo "#        Trigger Port       #" >> $LOG_FILE
	echo "#############################" >> $LOG_FILE
	cat /proc/trigger_port_list >> $LOG_FILE
fi

if [ -f /proc/url_blocking_list ]; then
	echo "#############################" >> $LOG_FILE
	echo "#        URL Blocking       #" >> $LOG_FILE
	echo "#############################" >> $LOG_FILE
	cat /proc/url_blocking_list >> $LOG_FILE
fi

echo "#############################" >> $LOG_FILE
echo "#          meminfo          #" >> $LOG_FILE
echo "#############################" >> $LOG_FILE

cat /proc/meminfo >> $LOG_FILE
echo "" >> $LOG_FILE

echo "#############################" >> $LOG_FILE
echo "#          modules          #" >> $LOG_FILE
echo "#############################" >> $LOG_FILE
lsmod >> $LOG_FILE
echo "" >> $LOG_FILE

echo "#############################" >> $LOG_FILE
echo "#          ps               #" >> $LOG_FILE
echo "#############################" >> $LOG_FILE
ps -ax >> $LOG_FILE
echo "" >> $LOG_FILE

echo "#############################" >> $LOG_FILE
echo "#          ifconfig         #" >> $LOG_FILE
echo "#############################" >> $LOG_FILE
ifconfig >> $LOG_FILE
echo "" >> $LOG_FILE

echo "#############################" >> $LOG_FILE
echo "#          route            #" >> $LOG_FILE
echo "#############################" >> $LOG_FILE
route -n>> $LOG_FILE
echo "" >> $LOG_FILE

echo "#############################" >> $LOG_FILE
echo "#        iptables -L -xv    #" >> $LOG_FILE
echo "#############################" >> $LOG_FILE
iptables -L -n -xv >> $LOG_FILE
echo "" >> $LOG_FILE

echo "#############################" >> $LOG_FILE
echo "#   iptables -L -t nat -xv  #" >> $LOG_FILE
echo "#############################" >> $LOG_FILE
iptables -L -n -t nat -xv >> $LOG_FILE
echo "" >> $LOG_FILE

echo "#############################" >> $LOG_FILE
echo "#          df               #" >> $LOG_FILE
echo "#############################" >> $LOG_FILE
df >> $LOG_FILE
echo "" >> $LOG_FILE

echo "#############################" >> $LOG_FILE
echo "#      security log         #" >> $LOG_FILE
echo "#############################" >> $LOG_FILE
cat /var/log/security >> $LOG_FILE
echo "" >> $LOG_FILE

if [ -f /var/log/l2tp.err ]; then
    echo "#############################" >> $LOG_FILE
    echo "#      L2TP log             #" >> $LOG_FILE
    echo "#############################" >> $LOG_FILE
    cat /var/log/l2tp.err >> $LOG_FILE
    echo "" >> $LOG_FILE
fi

if [ -f /var/log/sntp.log ]; then
    echo "#############################" >> $LOG_FILE
    echo "#      SNTP log             #" >> $LOG_FILE
    echo "#############################" >> $LOG_FILE
    cat /var/log/sntp.log >> $LOG_FILE
    echo "" >> $LOG_FILE
fi

if [ -f /var/log/dhcpc.log ]; then
    echo "#############################" >> $LOG_FILE
    echo "#      DHCP client log      #" >> $LOG_FILE
    echo "#############################" >> $LOG_FILE
    cat /var/log/dhcpc.log >> $LOG_FILE
    echo "" >> $LOG_FILE
fi

if [ -f /var/log/dns.log ]; then
    echo "#############################" >> $LOG_FILE
    echo "#      DNS log              #" >> $LOG_FILE
    echo "#############################" >> $LOG_FILE
    cat /var/log/dns.log >> $LOG_FILE
    echo "" >> $LOG_FILE
fi

if [ -f /var/log/route.log ]; then
    echo "#############################" >> $LOG_FILE
    echo "#      Route log            #" >> $LOG_FILE
    echo "#############################" >> $LOG_FILE
    cat /var/log/route.log >> $LOG_FILE
    echo "" >> $LOG_FILE
fi

echo "#############################" >> $LOG_FILE
echo "#         WAN1  Debug       #" >> $LOG_FILE
echo "#############################" >> $LOG_FILE
echo "ping 168.95.1.1" >> $LOG_FILE
ping 168.95.1.1 >> $LOG_FILE
echo "ping 220.210.194.67" >> $LOG_FILE
ping 220.210.194.67 >> $LOG_FILE
echo "ping www.google.com.tw" >> $LOG_FILE
ping www.google.com.tw >> $LOG_FILE
echo "ping www.flets" >> $LOG_FILE
ping www.flets >> $LOG_FILE
echo "" >> $LOG_FILE

echo "#############################" >> $LOG_FILE
echo "#          syslog           #" >> $LOG_FILE
echo "#############################" >> $LOG_FILE
logread >> $LOG_FILE
echo "" >> $LOG_FILE
