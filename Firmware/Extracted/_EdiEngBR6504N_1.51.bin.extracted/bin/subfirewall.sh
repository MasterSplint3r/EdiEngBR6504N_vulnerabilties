#!/bin/sh

TMP_FILE=/var/firewall.tmp

if [ -f $TMP_FILE ]; then
	echo "we readly have one firewall.sh running"
	OLD_PID=`cat $TMP_FILE`
	kill -9 $OLD_PID
#	exit 0
#else
#	echo "1" > $TMP_FILE
fi

echo "$$" > $TMP_FILE

#sleep 1

#include file
. /var/flash.inc
. /web/mode
SEC_LOG=/var/log/security

WAN=eth1

# if wireless ISP mode , set WAN to wlan0-vxd
if [ "$OP_MODE" = '1' ];then
	#WAN=wlan$WISP_WAN_ID-vxd
	WAN=br1
fi

#PPoE
if [ "$WAN_MODE" = "2" ]; then
	WAN=ppp0
	WAN1=ppp1
fi

#PPtP
if [ "$WAN_MODE" = "3" ]; then
	WAN=ppp0
fi

#L2TP
if [ "$WAN_MODE" = "6" ]; then
	WAN=ppp0
fi

EXT_IP0=`ifconfig $WAN | grep -i "addr:"`
EXT_IP1=`echo $EXT_IP0 | cut -f2 -d:`
EXT_IP=`echo $EXT_IP1 | cut -f1 -d " "`
if [ "$WAN1" != "" ]; then
	EXT2_IP0=`ifconfig $WAN1 | grep -i "addr:"`
	EXT2_IP1=`echo $EXT2_IP0 | cut -f2 -d:`
	EXT2_IP=`echo $EXT2_IP1 | cut -f1 -d " "`
fi
INT_IP0=`ifconfig $BRIDGE | grep -i "addr:"`
INT_IP1=`echo $INT_IP0 | cut -f2 -d:`
INT_IP=`echo $INT_IP1 | cut -f1 -d " "`	

if [ "$EXT_IP" = "" ]; then
	echo [`date +"%F %T"`]: [FIREWALL]: WAN is disconnect, abort... >> $SEC_LOG
	rm -f $TMP_FILE 2> /dev/null
	exit 0
else
	echo [`date +"%F %T"`]: [FIREWALL]: WAN IP is $EXT_IP setting firewall... >> $SEC_LOG
	echo [`date +"%F %T"`]: [FIREWALL]: WAN2 IP is $EXT2_IP setting firewall... >> $SEC_LOG
fi

echo "********* clean all iptables data **********"
iptables -I FORWARD -t mangle -i br0 -j DROP
iptables -F
iptables -t nat -F PREROUTING
iptables -t nat -F POSTROUTING

if [ "$NAT_ENABLE" = "1" ]; then
	iptables -t nat -A POSTROUTING -o $WAN -j MASQUERADE
	
	if [ "$MODE" = "-D_edimax_" ]; then	
		#add for pptp services.
		iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
	fi
	if [ "$WAN1" != "" ]; then
		iptables -t nat -A POSTROUTING -o $WAN1 -j MASQUERADE
	fi
fi

iptables -F -t mangle 
iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD
iptables -N ip-filter

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

iptables -I OUTPUT -m string --algo bm --string "Redirect" -j LOG --log-prefix "Web Admin: "

echo 1 > /proc/sys/net/ipv4/ip_forward



if [ "$MODE" = "-D_pci_" ] || [ "$MODE" = "-D_taiPci_" ]; then 
	echo 8240 > /proc/sys/net/ipv4/ip_conntrack_max 
	echo 16384 > /proc/sys/net/ipv4/route/max_size
	echo 8 > /proc/sys/net/ipv4/route/gc_elasticity
else
	echo 1024 > /proc/sys/net/ipv4/ip_conntrack_max  #removed by tommy on 11/02/2005
fi
#echo 7200 > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_established #add by tommy on 12/21/2005
echo 1800 > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_established #5day
echo 30  > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_syn_sent #120
echo 10  > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_syn_recv #60
echo 20  > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_fin_wait #120
echo 10  > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_close_wait #60
echo 10  > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_last_ack #30
echo 120 > /proc/sys/net/ipv4/netfilter/ip_conntrack_generic_timeout #600

#PPPoE
if [ "$WAN_MODE" = "2" ]; then
    if [ "$PPP_MTU" = "0" ]; then
        PPP_MTU=1392
		/bin/flash set PPP_MTU 1392
    fi
    MTU=`expr $PPP_MTU - 40`
    /bin/iptables -A FORWARD -o ppp0 -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --set-mss $MTU

    if [ "$WAN1" != "" ]; then
        if [ "$PPP_MTU1" = "0" ]; then
            PPP_MTU1=1392
    		/bin/flash set PPP_MTU1 1392
        fi
        MTU1=`expr $PPP_MTU1 - 40`
        /bin/iptables -A FORWARD -o ppp1 -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --set-mss $MTU1
    fi
fi
#PPtP
if [ "$WAN_MODE" = "3" ]; then
    if [ "$PPTP_MTU" = "0" ]; then
        PPTP_MTU=1392
		/bin/flash set PPTP_MTU 1392
    fi
    MTU=`expr $PPTP_MTU - 32`
    /bin/iptables -A FORWARD -o ppp0 -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --set-mss $MTU
fi

#L2TP
if [ "$WAN_MODE" = "6" ]; then
	if [ "$L2TP_MTU" = "0" ]; then
		L2TP_MTU=1392
		/bin/flash set L2TP_MTU 1392
	fi
	MTU=`expr $L2TP_MTU - 32`
	/bin/iptables -A FORWARD -o ppp0 -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --set-mss $MTU
fi

if [ "$NAT_ENABLE" = "1" ]; then
	echo "********** set NAT **********"
#	iptables -t nat -A POSTROUTING -o $WAN -j MASQUERADE
	iptables -t nat -A PREROUTING -i $WAN -d $INT_IP/$SUBNET_MASK -j DROP
	if [ "$WAN1" != "" ]; then
		iptables -t nat -A PREROUTING -i $WAN1 -d $INT_IP/$SUBNET_MASK -j DROP
	fi

	/bin/portfw.sh $INT_IP $EXT_IP 

	/bin/vserver.sh $INT_IP $EXT_IP 
	
	/bin/triggerport.sh $INT_IP $EXT_IP 

#	/bin/triggerport.sh 

	/bin/remote.sh $WAN $INT_IP 

	/bin/alg.sh 

	/bin/urlblocking.sh

	/bin/upnp.sh


else
	echo "NAT disable!!"
	/bin/remote.sh $WAN $INT_IP 

	/bin/alg.sh disable
	
	/bin/upnp.sh disable
	
	rmmod fv_fastnat
fi

	/bin/stcrout.sh 

if [ "$FIREWALL_ENABLE" = "1" ]; then
	echo "********** set Firewall **********"

	/bin/accessctl.sh 

	# /bin/urlblock.sh & ### move into triggerport.sh ###

	/bin/intrusion.sh $WAN
else
	echo "Firewall disable!!"
fi

#/bin/dmz.sh $INT_IP $EXT_IP
/bin/multidmz.sh $INT_IP
		
/bin/ddns.sh 

/bin/QoS.sh
 		
/bin/wlanapp.sh # 802.1x daemon will kill itself after interface down
# Disable following port from WAN
if [ "$NAT_ENABLE" = "1" ]; then
	if [ "$REMANG_ENABLE" != "1" ] || [ "$REMAN_PORT" != "80" ]; then
		iptables -t nat -A PREROUTING -i $WAN -p tcp --dport 80 -j DROP
	fi
fi

iptables -A INPUT -i $WAN -p udp -m multiport --dport 53 -j DROP 
iptables -A INPUT -i $WAN -p tcp --dport 53 -j DROP 
iptables -A INPUT -i $WAN -p tcp --dport 31727 -j DROP 

if [ "$MODE" = "-D_airlive_" ] || [ "$MODE" = "-D_planet_" ]; then
	TTL_ENABLE="1"
fi

if [ "$PPP_TTL_ENABLED" = "1" ] || [ "$TTL_ENABLE" = "1" ]; then
	if [ "$WAN_MODE" = "0" ] || [ "$WAN_MODE" = "1" ] || [ "$WAN_MODE" = "2" ]; then
		if [ "$MODE" = "-D_airlive_" ] || [ "$MODE" = "-D_planet_" ]; then
			
			case "$TTL_TYPE" in
				"0")	#Standard
					TTL_CMD="--ttl-dec 1"
					;;
				"1")	#TTL+1
					TTL_CMD="--ttl-inc 1"
					;;
				"2")	#TTL=1
					TTL_CMD="--ttl-set 2"
					;;
				"3")	#User Defined
					TTL_VALUE_A1=`expr $TTL_VALUE + 1`
					TTL_CMD="--ttl-set $TTL_VALUE_A1"
					;;
			esac			
				iptables -t mangle -A PREROUTING -i br0 -j TTL $TTL_CMD
				iptables -t mangle -A PREROUTING -i $WAN -j TTL $TTL_CMD
		else
			iptables -t mangle -A PREROUTING -i br0 -j TTL --ttl-inc 1
			iptables -t mangle -A PREROUTING -i $WAN -j TTL --ttl-inc 1
		fi		

	fi
fi
# Disable print protocol from WAN
if [ "$PS_ENABLE" = "1" ]; then
	iptables -A INPUT -i $WAN -p tcp --dport 515 -j DROP 
	iptables -A INPUT -i $WAN -p tcp --dport 631 -j DROP 
	iptables -A INPUT -i $WAN -p tcp -m multiport --dport 9100,9101,9102,9110,9111,9112 -j DROP
	iptables -A INPUT -i $WAN -p tcp -m multiport --dport 9120,9121,9122,9130,9131,9132 -j DROP
	iptables -A INPUT -i $WAN -p tcp -m multiport --dport 9140,9141,9142,9150,9151,9152 -j DROP
	iptables -A INPUT -i $WAN -p tcp -m multiport --dport 9160,9161,9162,9170,9171,9172 -j DROP 
fi


route add -net 239.0.0.0 netmask 255.0.0.0 br0
#add iptables limit connection modul
#rmmod ipt_connlimit 2 > /dev/null
#insmod /lib/modules/2.6.17.3-gcc-4.1-FV13XX.299/ipt_connlimit.ko

#limit upd connection
#iptables -I FORWARD -p! tcp   -m connlimit --connlimit-above 512 --connlimit-mask 32 -j DROP 


rm -f $TMP_FILE 2> /dev/null

# Fixed software reboot cause ping wan time out issue .
echo 0 > /proc/sys/net/ipv4/netfilter/ip_conntrack_icmp_timeout
sleep 1
echo 30 > /proc/sys/net/ipv4/netfilter/ip_conntrack_icmp_timeout