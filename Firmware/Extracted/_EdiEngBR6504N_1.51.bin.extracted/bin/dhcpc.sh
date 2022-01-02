#!/bin/sh

if [ $# -lt 2 ]; then echo "Usage: $0 interface {wait|no]";  exit 1 ; fi

SCRIPT_PATH=/etc/udhcpc
PIDFILE=/etc/udhcpc/udhcpc-$1.pid
CMD="-i $1 -p $PIDFILE -s $SCRIPT_PATH/$1.sh"

#include file
. /var/flash.inc

if [ "$2" = 'no' ]; then
	CMD="$CMD -n"

	# Generate deconfig script, used when DHCP request is failed

	echo "#!/bin/sh" > $SCRIPT_PATH/$1.deconfig
	echo "ifconfig $1 $IP_ADDR netmask $SUBNET_MASK" >> $SCRIPT_PATH/$1.deconfig
    echo "while route del -net default gw 0.0.0.0 dev $1" >> $SCRIPT_PATH/$1.deconfig
    echo "do :" >> $SCRIPT_PATH/$1.deconfig >> $SCRIPT_PATH/$1.deconfig
    echo "done" >> $SCRIPT_PATH/$1.deconfig >> $SCRIPT_PATH/$1.deconfig
	echo "route add -net default gw $DEFAULT_GATEWAY dev $1" >> $SCRIPT_PATH/$1.deconfig
    # added to start 802.1x and IAPP daemon
#    echo "iappauth.sh $1" >> $SCRIPT_PATH/$1.deconfig
    echo "init.sh ap wlan_app" >> $SCRIPTFILE_PATH/$1.deconfig	#Erwin
else
	# Generate deconfig script
	echo "#!/bin/sh" > $SCRIPT_PATH/$1.deconfig
#	echo "ifconfig $1 0.0.0.0" >> $SCRIPT_PATH/$1.deconfig
	echo "echo into $1.deconfig" >> $SCRIPT_PATH/$1.deconfig
fi

chmod +x $SCRIPT_PATH/$1.deconfig

if [ -f $PIDFILE ] ; then
	PID=`cat $PIDFILE`
	if [ "$PID" != "0" ]; then
		kill -9 $PID 2> /dev/null
   	fi
	rm -f $PIDFILE 2> /dev/null
fi

if [ "$DYNIP_HOSTNAME" != "" ]; then
	CMD="$CMD -h $DYNIP_HOSTNAME"
fi

udhcpc $CMD
