#!/bin/sh
#
# script file to start upgrade adsl module firmware.
#
Report=/var/upgrade.var

. /var/flash.inc
. /web/mode

echo "########################Upgrade adsl module###########################"

#ifconfig ra0 down
#ifconfig eth0 down
#ifconfig br0 down
brctl delif br0 ra0
brctl delif br0 eth0
tcc -s "ip addr 192.168.1.1"
ifconfig eth1 192.168.1.250
tftp -p -l /var/ras -r ras 192.168.1.1 2> $Report
echo  "$Report"
Resault= `cat $Report | grep -i "last timeout" | cut -d' ' -f 3`

echo "*****$Resault****"
echo "Upgrade finished !!" > $Report
if [ "$Resault" = "timeout" ]; then
echo "Upgrade fail !! "$Report
fi
brctl addif br0 ra0
brctl addif br0 eth0
sleep 10


echo "########################Upgrade END####################################"