#!/bin/sh
if [ $# -lt 1 ]; then echo "Usage: $0 interface {wait|no]";  exit 1 ; fi

WLAN_INTERFACE="ra0"
SET_WLAN="iwpriv $WLAN_INTERFACE set"
WRITE_E2P="iwpriv $WLAN_INTERFACE e2p"
READ_E2P="iwpriv $WLAN_INTERFACE e2p"
VAR_FILE=/var/rftest
VAR_FILE2=/var/rftest2
CNT_TIME=2000
SLEEP_TIME=10
#create include file
                                                                                                   
#include file

# $1 ==> ateFunc
# $2 ==> ateGain
# $3 ==> ateTxCount
# $4 ==> ateChan
# $5 ==> ateRate
# $6~$19 ==> e2pTxPower1~e2pTxPower14
# $20 ==> ateOffset
# $21 ==> ateMode
# $22 ==> ateBW
# $23 ==> ateAntenna
# $24 ==> e2pTxOffset
# $25 ==> Tx power delta configuration b
# $26 ==> Tx power delta configuration g
# $27 ==> Tx power delta configuration 20/40M
# $28 ==> Read E2P value
# $29 ==> Tx power delta configuration n
# $30 ==> ateMacID
if [ $3 -le 1000 ]; then
	SLEEP_TIME=1
elif [ $3 -le 2000 ]; then
	SLEEP_TIME=2
elif [ $3 -le 3000 ]; then
	SLEEP_TIME=3
elif [ $3 -le 4000 ]; then
	SLEEP_TIME=4
elif [ $3 -le 5000 ]; then
	SLEEP_TIME=5
else
	SLEEP_TIME=10
fi
#	SLEEP_TIME="1"

echo $SLEEP_TIME
#/bin/brctl delif br0 $WLAN_INTERFACE 2>/dev/null
echo ateFunc = $1 
echo ateGain = $2 
echo ateTxCount = $3 
echo ateChan = $4 
echo MCS = $5 
echo e2pTx1Power1~e2pTx1Power7 = $6 $7 $8 $9 $10 $11 $12
echo e2pTx2Power1~e2pTx2Power7 = $13 $14 $15 $16 $17 $18 $19 
echo ateOffset = $20 
echo ateMode = $21 
echo ateBW = $22 
echo ateAntenna = $23 
echo Tx power delta configuration b = $25 
echo Tx power delta configuration g = $26 
echo Tx power delta configuration 20/40M= $27 
echo ReadE2P= $28
echo Tx power delta configuration n = $29
echo MacID = $30
case "$1" in
	"ENABLEWIRELESS")
		/bin/wlan.sh ra0 1
		brctl addif br0 ra0

	;;
		
	"TXCONT")
                /sbin/ifconfig $WLAN_INTERFACE down
                /bin/sleep 1
                /sbin/rmmod rt2860ap
                /bin/sleep 1
                /sbin/insmod /bin/rt2860ap.ko
                /bin/sleep 2
                /sbin/ifconfig $WLAN_INTERFACE up
                /bin/sleep 2 
		                
#               $SET_WLAN ATETXPOW=$2
#                $SET_WLAN ATE=ATESTART
#               $SET_WLAN ATECHANNEL=$4
#               $SET_WLAN ATETXRATE=$5
#                $SET_WLAN ATE=TXFRAME
#                $SET_WLAN ATE=TXCONT
	;;	
	"CARRIER")
		$SET_WLAN ATE=ATESTART
		$SET_WLAN ATECHANNEL=$4
		$SET_WLAN ATETXMODE=$21
		$SET_WLAN ATETXMCS=$5
		$SET_WLAN ATETXBW=$22
		$SET_WLAN ATETXCNT=$3
		$SET_WLAN ATE=TXFRAME
		$SET_WLAN ATE=TXCARR

#                              iwpriv ra0 set ATE=ATESTART
#                              iwpriv ra0 set ATECHANNEL=1
#                              iwpriv ra0 set ATETXMODE=1
#                              iwpriv ra0 set ATETXMCS=7
#                              iwpriv ra0 set ATETXBW=0
#                              iwpriv ra0 set ATETXCNT=200
#                              iwpriv ra0 set ATE=TXFRAME
#                              iwpriv ra0 set ATE=TXCONT
	;;

	"MASK")
		echo "MASK"

#                              iwpriv ra0 set ATE=ATESTART
#                              iwpriv ra0 set ATECHANNEL=1
#                              iwpriv ra0 set ATETXMODE=1
#                              iwpriv ra0 set ATETXMCS=7
#                              iwpriv ra0 set ATETXBW=0
#                              iwpriv ra0 set ATETXCNT=200
#                              iwpriv ra0 set ATE=TXFRAME
#                              iwpriv ra0 set ATE=TXCONT
#                              iwpriv ra0 set ATETXPOW0=5
#                              iwpriv ra0 set ATETXPOW1=5

		$SET_WLAN ATE=ATESTART
		$SET_WLAN ATECHANNEL=$4
		$SET_WLAN ATETXMODE=$21
		$SET_WLAN ATETXMCS=$5
		$SET_WLAN ATETXBW=$22
		$SET_WLAN ATETXCNT=$3
		$SET_WLAN ATE=TXFRAME
		$SET_WLAN ATETXANT=$23
		$SET_WLAN ATE=TXCONT
		if [ $23 = 0 ]; then
				$SET_WLAN ATETXPOW0=$2
				$SET_WLAN ATETXPOW1=$2
		elif [ $23 = 1 ]; then
				$SET_WLAN ATETXPOW0=$2
		elif [ $23 = 2 ]; then
				$SET_WLAN ATETXPOW1=$2
		fi


	;;	
	
	"OFFSET")
		echo "OFFSET"
		$SET_WLAN ATE=ATESTART
		$SET_WLAN ATECHANNEL=$4
		$SET_WLAN ATETXMODE=$21
		$SET_WLAN ATETXMCS=$5
		$SET_WLAN ATETXCNT=$3		
		$SET_WLAN ATETXFREQOFFSET=$20
		$SET_WLAN ATE=TXFRAME
		$SET_WLAN ATE=TXCARR
	;;
	"TXFRAME")     
		$SET_WLAN ATE=ATESTART
		$SET_WLAN ATEDA=FF:FF:FF:FF:FF:FF
		$SET_WLAN ATESA=$30
		$SET_WLAN ATEBSSID=01:22:33:44:55:66
		$SET_WLAN ATECHANNEL=$4
		$SET_WLAN ATETXMODE=$21
		$SET_WLAN ATETXMCS=$5
		$SET_WLAN ATETXBW=$22
		$SET_WLAN ATETXCNT=$3	
		$SET_WLAN ATETXANT=$23
		$SET_WLAN ATETXGI=0
		$SET_WLAN ATETXLEN=1024
		Power1=0
		Power2=0
		case "$4" in
		"1")
			Power1=`$READ_E2P 52 | grep :0x | cut -f 2 -d : | cut -b 3-4`
			Power2=`$READ_E2P 60 | grep :0x | cut -f 2 -d : | cut -b 3-4`
		;;
		"2")
			Power1=`$READ_E2P 52 | grep :0x | cut -f 2 -d : | cut -b 5-6`
			Power2=`$READ_E2P 60 | grep :0x | cut -f 2 -d : | cut -b 5-6`
		;;
		"3")
			Power1=`$READ_E2P 54 | grep :0x | cut -f 2 -d : | cut -b 3-4`
			Power2=`$READ_E2P 62 | grep :0x | cut -f 2 -d : | cut -b 3-4`
		;;
		"4")
			Power1=`$READ_E2P 54 | grep :0x | cut -f 2 -d : | cut -b 5-6`
			Power2=`$READ_E2P 62 | grep :0x | cut -f 2 -d : | cut -b 5-6`
		;;
		"5")
			Power1=`$READ_E2P 56 | grep :0x | cut -f 2 -d : | cut -b 3-4`
			Power2=`$READ_E2P 64 | grep :0x | cut -f 2 -d : | cut -b 3-4`
		;;
		"6")
			Power1=`$READ_E2P 56 | grep :0x | cut -f 2 -d : | cut -b 5-6`
			Power2=`$READ_E2P 64 | grep :0x | cut -f 2 -d : | cut -b 5-6`
		;;
		"7")
			Power1=`$READ_E2P 58 | grep :0x | cut -f 2 -d : | cut -b 3-4`
			Power2=`$READ_E2P 66 | grep :0x | cut -f 2 -d : | cut -b 3-4`
		;;
		"8")
			Power1=`$READ_E2P 58 | grep :0x | cut -f 2 -d : | cut -b 5-6`
			Power2=`$READ_E2P 66 | grep :0x | cut -f 2 -d : | cut -b 5-6`
		;;
		"9")
			Power1=`$READ_E2P 5A | grep :0x | cut -f 2 -d : | cut -b 3-4`
			Power2=`$READ_E2P 68 | grep :0x | cut -f 2 -d : | cut -b 3-4`
		;;
		"10")
			Power1=`$READ_E2P 5A | grep :0x | cut -f 2 -d : | cut -b 5-6`
			Power2=`$READ_E2P 68 | grep :0x | cut -f 2 -d : | cut -b 5-6`
		;;
		"11")
			Power1=`$READ_E2P 5C | grep :0x | cut -f 2 -d : | cut -b 3-4`
			Power2=`$READ_E2P 6A | grep :0x | cut -f 2 -d : | cut -b 3-4`
		;;
		"12")
			Power1=`$READ_E2P 5C | grep :0x | cut -f 2 -d : | cut -b 5-6`
			Power2=`$READ_E2P 6A | grep :0x | cut -f 2 -d : | cut -b 5-6`
		;;
		"13")
			Power1=`$READ_E2P 5E | grep :0x | cut -f 2 -d : | cut -b 3-4`
			Power2=`$READ_E2P 6C | grep :0x | cut -f 2 -d : | cut -b 3-4`
		;;
		"14")
			Power1=`$READ_E2P 5E | grep :0x | cut -f 2 -d : | cut -b 5-6`
			Power2=`$READ_E2P 6C | grep :0x | cut -f 2 -d : | cut -b 5-6`
		;;
		esac
		
		echo "Power1=$Power1"
		echo "Power2=$Power2"
		$SET_WLAN ATETXPOW0=$Power1
		$SET_WLAN ATETXPOW1=$Power2
		$SET_WLAN ATE=TXFRAME
		;;
	"RXFRAME")
		echo "RXFRAME"
		
		$SET_WLAN ATE=ATESTART
		$SET_WLAN ATECHANNEL=$4
		$SET_WLAN ResetCounter=0
		$SET_WLAN ATETXMODE=$21
		$SET_WLAN ATETXMCS=$5
		$SET_WLAN ATETXBW=$22
   $SET_WLAN ATE=RXFRAME
		$SET_WLAN ATERXFER=1
	;;
	
	"TXPOWER")
		echo "TXPOWER"
		if [ $23 = 0 ]; then
				$SET_WLAN ATETXPOW0=$2
				$SET_WLAN ATETXPOW1=$2
		elif [ $23 = 1 ]; then
				$SET_WLAN ATETXPOW0=$2
		elif [ $23 = 2 ]; then
				$SET_WLAN ATETXPOW1=$2
		fi

	;;
	
	"ATESTOP")
		echo "ATESTART"
		$SET_WLAN ATE=ATESTART
	;;
	
	"ATETXFREQOFFSET")
		echo "ATETXFREQOFFSET"
		$SET_WLAN ATETXFREQOFFSET=$20
	;;
	"E2PTXFREQOFFSET")
	  echo "E2PTXFREQOFFSET"		
    height=`iwpriv ra0 e2p 3A | grep :0x | cut -f 2 -d : | cut -b 3-4`
    echo $WRITE_E2P 3A=$height$24
    $WRITE_E2P 3A=$height$24
	;;


	
	"E2PTXPOWER")
	  echo "E2PTXPOWER"
	  if [ "$6" != "null" ]; then
			$WRITE_E2P 52=$6
			echo "Test null"
	  fi
	  if [ "$7" != "null" ]; then
			$WRITE_E2P 54=$7
	  fi
	  if [ "$8" != "null" ]; then
			$WRITE_E2P 56=$8
	  fi
	  if [ "$9" != "null" ]; then
			$WRITE_E2P 58=$9
	  fi  
	  if [ "$10" != "null" ]; then
			$WRITE_E2P 5A=$10
	  fi
	  if [ "$11" != "null" ]; then
	 		$WRITE_E2P 5C=$11
	  fi
	  if [ "$12" != "null" ]; then
			$WRITE_E2P 5E=$12
	  fi 
	  if [ "$13" != "null" ]; then
			$WRITE_E2P 60=$13
	  fi
	  if [ "$14" != "null" ]; then
			$WRITE_E2P 62=$14
	  fi 
	  if [ "$15" != "null" ]; then
			$WRITE_E2P 64=$15
	  fi
	  if [ "$16" != "null" ]; then
			$WRITE_E2P 66=$16
	  fi
	  if [ "$17" != "null" ]; then
			$WRITE_E2P 68=$17
	  fi  
	  if [ "$18" != "null" ]; then
			$WRITE_E2P 6A=$18
	  fi  
	  if [ "$19" != "null" ]; then
			$WRITE_E2P 6C=$19
	  fi 	    

	;;

	"DELTA")
	  echo "DELTA"  
		low=`iwpriv ra0 e2p DE | grep :0x | cut -f 2 -d : | cut -b 5-6`
		$WRITE_E2P DE=$25$low
		low=`iwpriv ra0 e2p E2 | grep :0x | cut -f 2 -d : | cut -b 5-6`
		$WRITE_E2P E2=$26$low
		low=`iwpriv ra0 e2p EB | grep :0x | cut -f 2 -d : | cut -b 5-6`
		$WRITE_E2P EB=$29$low
		$WRITE_E2P 50=$27
    /sbin/ifconfig $WLAN_INTERFACE down 2> /dev/null

    /sbin/rmmod rt2860ap 2> /dev/null

    /sbin/insmod /bin/rt2860ap.ko 2> /dev/null

    /sbin/ifconfig $WLAN_INTERFACE up 2> /dev/null

		
	;;
	"READE2P")
		readValue=`iwpriv ra0 e2p $28 | grep :0x | cut -f 2 -d : |  cut -b 3-6`
		echo $readValue > $VAR_FILE2
	;;
	"READTX1")
		tx11=`$READ_E2P 52 | grep :0x | cut -f 2 -d : | cut -b 3-6`
		tx12=`$READ_E2P 54 | grep :0x | cut -f 2 -d : | cut -b 3-6`	
		tx13=`$READ_E2P 56 | grep :0x | cut -f 2 -d : | cut -b 3-6`	
		tx14=`$READ_E2P 58 | grep :0x | cut -f 2 -d : | cut -b 3-6`	
		tx15=`$READ_E2P 5A | grep :0x | cut -f 2 -d : | cut -b 3-6`	
		tx16=`$READ_E2P 5C | grep :0x | cut -f 2 -d : | cut -b 3-6`
		tx17=`$READ_E2P 5E | grep :0x | cut -f 2 -d : | cut -b 3-6`
		
		echo "$tx11 $tx12 $tx13 $tx14 $tx15 $tx16 $tx17" > $VAR_FILE
		
	;;
		"READTX2")
		tx21=`$READ_E2P 60 | grep :0x | cut -f 2 -d : | cut -b 3-6`
		tx22=`$READ_E2P 62 | grep :0x | cut -f 2 -d : | cut -b 3-6`	
		tx23=`$READ_E2P 64 | grep :0x | cut -f 2 -d : | cut -b 3-6`	
		tx24=`$READ_E2P 66 | grep :0x | cut -f 2 -d : | cut -b 3-6`	
		tx25=`$READ_E2P 68 | grep :0x | cut -f 2 -d : | cut -b 3-6`	
		tx26=`$READ_E2P 6A | grep :0x | cut -f 2 -d : | cut -b 3-6`
		tx27=`$READ_E2P 6C | grep :0x | cut -f 2 -d : | cut -b 3-6`
		echo "$tx21 $tx22 $tx23 $tx24 $tx25 $tx26 $tx27" > $VAR_FILE
	;;
esac