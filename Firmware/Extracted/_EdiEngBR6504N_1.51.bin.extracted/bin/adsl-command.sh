#!/bin/sh

#include file
flash all2 > /var/flash.inc
. /var/flash.inc
CMD_FILE=/var/adsl_cmd.var
CMD_OUT_FILE=/var/adsl_out.var
STATUS_FILE=/var/adsl_status.var
ENCAP=llc
ATMQOS=null
MODE=multimode
ANNEX=b

brCheck=`brctl show | grep eth1 | cut -de -f 2`

if [ "$brCheck" = "th1" ]; then
	brctl delif br0 eth1
fi



# $1==1 : write command to adsl.
#	$1==2 :   read adsl status to file.
#
if [ "$1" = '1' ]; then
	echo "=============Write command================"
	case "$ADSL_ENCAP" in
		"0")
			NCAP=llc
			;;
		"1")
			NCAP=vcmux
			;;
		"2")
			NCAP=llc
			;;
		"3")
			NCAP=vcmux
			;;
		"4")
			NCAP=llc
			;;
		"5")
			NCAP=vcmux
			;;
		"6")
			NCAP=llc
			;;
		"7")
			NCAP=vcmux
			;;
	esac
	case "$ADSL_ADSLMode" in
		"0")
			MODE=multimode
			;;
		"1")
			MODE=adsl2plus
			;;
		"2")
			MODE=adsl2
			;;
		"3")
			MODE=t1.413
			;;
		"4")
			MODE=gdmt
			;;
		"5")
			MODE=glite
			;;
	esac	
	case "$ADSL_ADSLType" in
		"0")
			ANNEX=a
			;;
		"1")
			ANNEX=j
			;;
		"2")
			ANNEX=m
			;;
		"3")
			ANNEX=al
			;;
	esac

		
	
	case "$ADSL_ATM" in
		"0")
			ATMQOS=ubr
			;;
		"1")
			ATMQOS=cbr
			;;
		"2")
			ATMQOS=vbr
			;;
		"3")
			ATMQOS=gfr
			;;
	esac	
	echo "sys edit autoexec.net" > $CMD_FILE
	
	echo "wan ghs set annex $ANNEX" >> $CMD_FILE
	
	echo "wan atm set $ADSL_VPI $ADSL_VCI $NCAP" >> $CMD_FILE
	
	echo "wan adsl opencmd $MODE" >> $CMD_FILE
	
	echo "wan adsl reset" >> $CMD_FILE
	
	if [ "$ATMQOS" != "null" ]; then
		echo "wan atm setqos $ATMQOS $ADSL_PCR $ADSL_SCR $ADSL_MBS" >> $CMD_FILE
	fi
	echo "" >> $CMD_FILE
	
	echo "sys reboot" >> $CMD_FILE
	
	/bin/tcc -w
	
	#read status
elif [ "$1" = '2' ]; then
echo "=============Read Status================"
	#file format
	#
	#line 1:firmware version
		echo	"wan adsl fwversion" > $CMD_FILE

	#line 2:line state up/down
		echo "wan adsl status" 	>> $CMD_FILE

	#line 3:SNR Margin Downstream
	#line 5:Line Attenuation Downstream
	
		echo "wan adsl linedata near"	>> $CMD_FILE
		
	#line 4:SNR Margin Upstream
	#line 6:Line Attenuation Upstream
		echo "wan adsl linedata far"	>> $CMD_FILE

	#line 7:Data Rate Downstream
	#line 8:Data Rate Upstream
		echo "wan adsl chandata"	>> $CMD_FILE

	tcc -r 
	
	#get firmware version.
	

		fwversion=`cat $CMD_OUT_FILE | grep DMT | cut -f 2- -d" " `
		echo "######version=$fwversion######"
		if [ "$fwversion" = '' ]; then
			echo "Get version fail!" > $STATUS_FILE
		else
				echo "$fwversion" > $STATUS_FILE
		fi
		
	#get line state
		lineState=`cat $CMD_OUT_FILE | grep current |cut -f 2 -d: `
		echo "######line state=$lineState######"
		if [ "$lineState" = '' ]; then
			echo "Get lineState fail!" >> $STATUS_FILE
		else
				echo "$lineState" >> $STATUS_FILE
		fi	
	# get line data and attenuation
		linedataDw=`cat $CMD_OUT_FILE | grep "noise margin downstream" | cut -f 2 -d: `
		linedataUp=`cat $CMD_OUT_FILE | grep "noise margin upstream" | cut -f 2 -d: `
		attenuationDw=`cat $CMD_OUT_FILE | grep "attenuation downstream" | cut -f 2 -d: `
		attenuationUp=`cat $CMD_OUT_FILE | grep "attenuation upstream" | cut -f 2 -d: `
		echo "######line data Upstream=$linedataUp"
		echo "######line data Downstream=$linedataDw"
		echo "######attenuation data Upstream=$attenuationUp"
		echo "######attenuation data Downstream=$attenuationDw"
		if [ "$linedataDw" = '' ]; then
			echo "0db" >> $STATUS_FILE
		else
				echo "$linedataDw" >> $STATUS_FILE
		fi	
		if [ "$linedataUp" = '' ]; then
			echo "0db" >> $STATUS_FILE
		else
				echo "$linedataUp" >> $STATUS_FILE
		fi		
		
		if [ "$attenuationDw" = '' ]; then
			echo "0db" >> $STATUS_FILE
		else
				echo "$attenuationDw" >> $STATUS_FILE
		fi		
		if [ "$attenuationUp" = '' ]; then
			echo "0db" >> $STATUS_FILE
		else
				echo "$attenuationUp" >> $STATUS_FILE
		fi			
	
		
	# get data rate
		dataRateUp=`cat $CMD_OUT_FILE | grep "far-end interleaved"  | cut -f 2 -d: `
		dataRateDw=`cat $CMD_OUT_FILE | grep "near-end interleaved" | cut -f 2 -d: `
		echo "######Data rate  Upstream=$dataRateUp######"
		echo "######Data rate Downstream=$dataRateDw######"
		if [ "$dataRateDw" = '' ]; then
			echo "0kbps" >> $STATUS_FILE
		else
				echo "$dataRateDw" >> $STATUS_FILE
		fi			
		if [ "$dataRateUp" = '' ]; then
			echo "0kbps" >> $STATUS_FILE
		else
				echo "$dataRateUp" >> $STATUS_FILE
		fi				

#tccconsole output
elif [ "$1" = '3' ]; then

tcc -s "$2"

fi

if [ "$brCheck" = "th1" ]; then
	brctl addif br0 eth1
fi