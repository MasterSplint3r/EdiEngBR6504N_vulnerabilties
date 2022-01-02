#!/bin/sh

echo "-----> ALG"

. /var/flash.inc
. /web/mode
ALG_TBL=`echo $APP_LAYER_GATEWAY | cut -f2 -d=`

MOD=/lib/modules/2.4.25-386/ip_conntrack_
NAT=/lib/modules/2.4.25-386/ip_nat_

RMMOD=ip_conntrack_
RMNAT=ip_nat_

AMANDA=amanda
EGG=egg
FTP=ftp
H323=h323
IRC=irc
MMS=mms
QUAKE3=quake3
TALK=talk
TFTP=tftp
STARCRAFT=starcraft
MSN=msn
GRE=proto_gre
PPTP=pptp
IPSEC=ipsec
L2TP=l2tp
RTSP=rtsp
echo "remove ALG modules..."

rmmod $RMNAT$AMANDA 2> /dev/null
rmmod $RMMOD$AMANDA 2> /dev/null

rmmod $RMMOD$EGG 2> /dev/null

rmmod $RMNAT$FTP 2> /dev/null
rmmod $RMMOD$FTP 2> /dev/null

rmmod $RMNAT$H323 2> /dev/null
rmmod $RMMOD$H323 2> /dev/null

rmmod $RMNAT$IRC 2> /dev/null
rmmod $RMMOD$IRC 2> /dev/null

rmmod $RMNAT$MMS 2> /dev/null
rmmod $RMMOD$MMS 2> /dev/null

rmmod $RMNAT$QUAKE3 2> /dev/null
rmmod $RMMOD$QUAKE3 2> /dev/null

rmmod $RMNAT$TALK 2> /dev/null
rmmod $RMMOD$TALK 2> /dev/null

rmmod $RMNAT$TFTP 2> /dev/null
rmmod $RMMOD$TFTP 2> /dev/null

rmmod $RMNAT$STARCRAFT 2> /dev/null
rmmod $RMMOD$STARCRAFT 2> /dev/null

rmmod $RMNAT$MSN 2> /dev/null
rmmod $RMMOD$MSN 2> /dev/null

rmmod $RMNAT$PPTP 2> /dev/null
rmmod $RMMOD$PPTP 2> /dev/null
rmmod $RMNAT$GRE 2> /dev/null
rmmod $RMMOD$GRE 2> /dev/null

rmmod $IPSEC 2> /dev/null

rmmod $RMNAT$RTSP 2> /dev/null
rmmod $RMMOD$RTSP 2> /dev/null

#add iptables limit connection modul
#rmmod ipt_connlimit 2 > /dev/null
#insmod /lib/modules/2.6.17.3-gcc-4.1-FV13XX.299/ipt_connlimit.ko

if [ "$1" = "disable" ]; then
	exit 0
fi

i=0

ALG_TMP=a

while [ "$ALG_TMP" != "" ]
do
	COUNT=`expr $i + 1`
	
	TMP_ALG=$ALG_TMP
	
	ALG_TMP=`echo $ALG_TBL | cut -f$COUNT -d ','`

	if [ "$TMP_ALG" = "$ALG_TMP" ]; then
		break
	fi

	case "$ALG_TMP" in
		"amanda")
			insmod $MOD$AMANDA
			insmod $NAT$AMANDA
			;;
		"egg")
			insmod $MOD$EGG
			;;
		"ftp")
			insmod $MOD$FTP
			insmod $NAT$FTP
			;;
		"h323")
			insmod $MOD$H323
			insmod $NAT$H323
			;;
		"irc")
			insmod $MOD$IRC
			insmod $NAT$IRC
			;;
		"mms")
			insmod $MOD$MMS
			insmod $NAT$MMS
			;;
		"quake3")
			insmod $MOD$QUAKE3
			insmod $NAT$QUAKE3
			;;
		"talk")
			insmod $MOD$TALK
			insmod $NAT$TALK
			;;
		"tftp")
			insmod $MOD$TFTP
			insmod $NAT$TFTP
			;;
		"starcraft")
			insmod $MOD$STARCRAFT
			insmod $NAT$STARCRAFT
			;;
		"msn")
			insmod $MOD$MSN
			insmod $NAT$MSN
			;;
		"ipsec")
			insmod $MOD$IPSEC
			insmod $MOD$L2TP
			insmod /lib/modules/2.6.17.3-gcc-4.1-FV13XX.299/fvt13xx/fv_alg_esp.ko
			rmmod fv_alg_esp
			#insmod /lib/modules/2.6.17.3-gcc-4.1-FV13XX.299/fvt13xx/$IPSEC
			;;
		"pptp")
			if [ "$MODE" = "-D_jensen_" ]; then
				insmod $MOD$PPTP
				insmod $NAT$PPTP
			fi
			
			;;
		"rtsp")
			insmod $MOD$RTSP
			insmod $NAT$RTSP
			;;
	esac

	i=`expr $i + 1`
done	

# The pptp Vitual server will conflict with PPTP ALG, So if VS is set disable ALG:

if [ "$MODE" = "-D_jensen_" ]; then
	PPTPD_INNER=`iptables -L -n -t nat | grep 1723`
	if [ "$PPTPD_INNER" != "" ]; then
		rmmod $RMNAT$PPTP 2> /dev/null
		rmmod $RMMOD$PPTP 2> /dev/null
	fi
fi

