#!/bin/sh
#
# script file to Static Routing config file
#
# Usage: stcrout.sh

OUTFILE=/var/routmp.txt

. /var/flash.inc
. /web/mode

if [ -f $OUTFILE ]; then

	. $OUTFILE
	if [ $SROUT_TBL_TMP_NUM -gt 0 ] && [ $SROUT_ENABLED -gt 0 ]; then
		num=1
		while [ $num -le $SROUT_TBL_TMP_NUM ];
		do

		eval "rout_arg="\$SROUT_TBL_TMP$num""
		dest_ip=`echo $rout_arg | cut -f1 -d,`
		mask=`echo $rout_arg | cut -f2 -d,`
		num=`expr $num + 1`
	
		echo "route del -net $dest_ip netmask $mask"
		route del -net $dest_ip netmask $mask
		done
		rm -f $OUTFILE
	fi
fi
#######################################################################################3
if [ "$MODE" = "-D_edimax_" ]; then

	if [ "$SROUT_ENABLED" = "0" ]; then
		echo "Static Routing disable!"
		exit 0
	fi
else

	if [ "$SROUT_ENABLED" = "0" ] || [ "$NAT_ENABLE" = "1" ]; then
		echo "Static Routing disable!"
		exit 0
	fi
fi


if [ $SROUT_TBL_NUM -gt 0 ] && [ $SROUT_ENABLED -gt 0 ]; then
	echo "Static Routing enable!"
        #joseph add---Nov 04,2005-----------
	iptables -t nat -F PREROUTING
	#------------------------------
	echo "SROUT_NUM=$SROUT_TBL_NUM"
	echo "SROUT_TBL_TMP_NUM=$SROUT_TBL_NUM" >> $OUTFILE
	num=1
	while [ $num -le $SROUT_TBL_NUM ];
	do

	eval "rout_arg="\$SROUT_TBL$num""
	echo "SROUT_TBL_TMP$num=$rout_arg" >> $OUTFILE
	dest_ip=`echo $rout_arg | cut -f1 -d,`
	mask=`echo $rout_arg | cut -f2 -d,`
	gateway=`echo $rout_arg | cut -f3 -d,`
	hop_count=`echo $rout_arg | cut -f4 -d,`
	interface=`echo $rout_arg | cut -f5 -d,`
	num=`expr $num + 1`

	if [ "$interface" = "0" ]; then
		interface="br0"
		
	else
		if [ "$WAN_MODE" = "2" ] || [ "$WAN_MODE" = "3" ] || [ "$WAN_MODE" = "6" ]; then
			interface="ppp0"
		else
			interface="eth1"
		fi
		if [ "$MODE" = "-D_edimax_" ]; then		
					interface="eth1"
		fi
	fi
if [ "$MODE" = "-D_edimax_" ]; then
	if [ "$gateway" = "0.0.0.0" ]; then
		echo "route add -net $dest_ip netmask $mask metric $hop_count dev $interface"
		route add -net $dest_ip netmask $mask metric $hop_count dev $interface
	else
		echo "route add -net $dest_ip netmask $mask gw $gateway metric $hop_count dev $interface"
		route add -net $dest_ip netmask $mask gw $gateway metric $hop_count dev $interface
	fi
else	
		echo "route add -net $dest_ip netmask $mask gw $gateway metric $hop_count dev $interface"
		route add -net $dest_ip netmask $mask gw $gateway metric $hop_count dev $interface
fi
	done
fi
