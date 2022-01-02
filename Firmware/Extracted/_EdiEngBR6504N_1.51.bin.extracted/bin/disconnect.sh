#!/bin/sh
LINKFILE=/etc/ppp/link0
LINKFILE1=/etc/ppp/link1
PPPFILE=/var/run/ppp0.pid
PPPFILE1=/var/run/ppp1.pid

WAN_INTERFACE=eth1			# Rex, Fixed me, this should be same as init.sh
#MODE=`cat /web/mode`
. /web/mode
#create include file
#if [ ! -f /etc/flash.inc ]; then
#/bin/create_flash.sh
#fi

#include file
#. /etc/flash.inc

#
killall dhid 2> /dev/null

killall upnpd 2> /dev/null

killall dnrd 2> /dev/null

#

if [ -f /tmp/old_mode ]; then
	OLD_MODE=`cat /tmp/old_mode`
	case "$OLD_MODE" in
	"0")
		echo "old mode is DHCP"
		# Delete DHCP client process
		killall udhcpc 2> /dev/null
		killall rdisc 2> /dev/null
	;;

	"1")
		echo "old mode is static IP"
	;;
    
	"2")
		echo "old mode is PPPoE"
		if [ "$1" = "all" ] || [ "$1" != "pppoe" ]; then
			if [ "$1" != "option" ]; then			# disconnect.sh option will call by pppd
				killall pppoe.sh 2> /dev/null
				killall pppd 2> /dev/null
			fi
		fi
#		killall pppoe 2> /dev/null
				
				
	if [ "$MODE" != "-D_pci_" ]; then
		echo "killall pppd"
		killall pppd 2> /dev/null
		
	fi
		
		
		
		
		
		if [ "$1" = "pppoe" ]; then
			if [ "$2" = "0" ]; then
				#pid0=`ps | grep "pppd 0" | cut -f 2 -d " "`
				pid0=`ps | grep "pppd 0" | grep -v "grep" | tr -s [" "] | cut -f 2 -d " "`
				
				if [ "$pid0" != "" ]; then
					kill -15 $pid0
				fi
			elif [ "$2" = "1" ]; then
				#pid1=`ps | grep "pppd 1" | cut -f 2 -d " "`
				pid1=`ps | grep "pppd 1" | grep -v "grep" | tr -s [" "] | cut -f 2 -d " "`
				if [ "$pid1" != "" ]; then
					kill -15 $pid1
				fi
			else
				killall pppd 2> /dev/null
			fi
		fi
        ;;
       
	"3")
		echo "old mode is PPTP"
		if [ "$1" = "all" ] || [ "$1" != "pptp" ]; then
			if [ "$1" != "option" ]; then
				killall pptp.sh 2> /dev/null
			fi
		fi
		killall udhcpc 2> /dev/null
		killall rdisc 2> /dev/null
		killall pptp 2> /dev/null
		killall pppd 2> /dev/null
        ;;

	"4")
		echo "old mode is BigBond"
		killall udhcpc 2> /dev/null
		killall bpalogin 2> /dev/null
		killall rdisc 2> /dev/null
        ;;
	
	"6")
		echo "old mode is L2TP"
		if [ "$1" = "all" ] || [ "$1" != "l2tp" ]; then
			if [ "$1" != "option" ]; then
			killall l2tp.sh 2> /dev/null
			fi
		fi
   #killall l2tpd 2> /dev/null
   /bin/handlers/l2tp-control "exit"
   sleep 1
		killall pppd 2> /dev/null
		killall udhcpc 2> /dev/null
		killall rdisc 2> /dev/null   
        ;;
	esac
fi

if [ "$1" = "all" ]; then
	sleep 2
fi

ifconfig eth1 0.0.0.0

rm /etc/resolv.conf 2> /dev/null
rm /var/run/dns-tmp 2> /dev/null

if [ -r "$LINKFILE" ]; then
	if  [ "$1" = "pppoe" -a "$2" = "1" ]; then
		:
	else
		rm $LINKFILE 2> /dev/null
	fi
fi
if [ -r "$LINKFILE1" ]; then
	if  [ "$1" = "pppoe" -a "$2" = "0" ]; then
		:
	else
		rm $LINKFILE1 2> /dev/null
	fi
fi
if [ -r "$PPPFILE" ]; then
	if  [ "$1" = "pppoe" -a "$2" = "1" ]; then
		:
	else
		rm $PPPFILE 2> /dev/null
	fi
fi
if [ -r "$PPPFILE1" ]; then
	if  [ "$1" = "pppoe" -a "$2" = "0" ]; then
		:
	else
		rm $PPPFILE1 2> /dev/null
	fi
fi

rm jj1 2> /dev/null
rm jj2 2> /dev/null

iptables -F
iptables -F -t nat
