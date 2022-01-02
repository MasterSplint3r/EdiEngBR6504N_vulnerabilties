#!/bin/sh

TEMPFILE=/var/run/wanstat
TEMPFILE1=/var/run/wanstat1
TMP1=/var/run/jj1
TMP2=/var/run/jj2
TMP3=/var/run/jj3

#include file
. /var/flash.inc
#include mode
. /web/mode


ifconfig eth1 | grep "HWaddr" > $TMP1
HW_MAC=`cut -f 11 -d" " $TMP1`

echo "$DNS1" > $TMP1
dns1=`cut -f 2 -d"=" $TMP1 | cut -f 1 -d":"`

echo "$DNS2" > $TMP1
dns2=`cut -f 2 -d"=" $TMP1 | cut -f 1 -d":"`

dns_flag=0
if [ "$dns1" != "0.0.0.0" ]; then
		dns_flag=1
fi
if [ "$dns2" != "0.0.0.0" ]; then
		dns_flag=1
fi
if [ "$WAN_MODE" = "0" ]; then
	connect=`ifconfig eth1 | grep "inet addr"`
	if [ "$connect" ]; then
		if [ -f /web/cosy ]; then
			echo "유동 IP 연결됨" > $TEMPFILE
		else
			echo "Dynamic IP connect" > $TEMPFILE
		fi
		ifconfig eth1 | grep "inet addr" > $TMP1
		cut -f 2 -d":" $TMP1 > $TMP2
		pat=`cut -f 1 -d" " $TMP2`
		echo "$pat" >> $TEMPFILE
	
		pat=`cut -f 4 -d":" $TMP1`
		echo "$pat" >> $TEMPFILE
	else
		if [ -f /web/cosy ]; then
			echo "유동 IP 연결안됨" > $TEMPFILE
		else
			echo "Dynamic IP disconnect" > $TEMPFILE
		fi
		echo "" >> $TEMPFILE
		echo "" >> $TEMPFILE
	fi
	
	echo "$HW_MAC" >> $TEMPFILE

	if [ "$dns_flag" = "0" ]; then
		pat=`head -n 1 /var/run/dns-tmp | tail -n 1 | cut -f 1 -d":" `
		echo "$pat" >> $TEMPFILE
    	pat=`head -n 2 /var/run/dns-tmp | tail -n 1 | cut -f 1 -d":" `
		echo "$pat" >> $TEMPFILE
	else
		if [ "$dns1" = "0.0.0.0" ]; then
			echo "" >> $TEMPFILE
		else
			echo "$dns1" >> $TEMPFILE
		fi
		if [ "$dns2" = "0.0.0.0" ]; then
			echo "" >> $TEMPFILE
		else
			echo "$dns2" >> $TEMPFILE
		fi
	fi
fi

if [ "$WAN_MODE" = "1" ]; then
	if [ -f /web/cosy ]; then
		echo "고정 IP 연결됨" > $TEMPFILE
	else
		echo "Fixed IP connect" > $TEMPFILE
	fi
	echo "$WAN_IP_ADDR" | cut -f 2 -d"=" >> $TEMPFILE
	echo "$WAN_SUBNET_MASK" | cut -f 2 -d"=" >> $TEMPFILE
	echo "$HW_MAC" >> $TEMPFILE
	if [ "$dns_flag" = "0" ]; then
        pat=`head -n 1 /var/run/dns-tmp | tail -n 1 | cut -f 1 -d":" `
		echo "$pat" >> $TEMPFILE
		echo "" >> $TEMPFILE
	else
		echo "$dns1" >> $TEMPFILE
		echo "$dns2" >> $TEMPFILE
	fi
fi

if [ "$WAN_MODE" = "2" ]; then
#----------------------------------Erwin Liao 19.08.03----------------------------------------
	if [ -f /etc/ppp/link0 ]; then
		connect=1
	else
		connect=""
	fi
#	connect=`ifconfig ppp0 | grep "inet addr"`
#---------------------------------------------------------------------------------
	ifconfig ppp0 | grep "inet addr" > $TMP1
	cut -f 2 -d":" $TMP1 > $TMP2
	pat=`cut -f 1 -d" " $TMP2`
	PPPName="ADSL(PPPoE)"
	if [ "$MODEL" = "-D_7264Wn_" ]; then
		if [ "$ADSL_ENCAP" = "3" ] || [ "$ADSL_ENCAP" = "4" ]; then
			    PPPName=PPPoA
		fi
	fi		
	if [ "$connect" ]; then
		if [ -f /web/cosy ]; then	
			echo "$PPPName 연결됨" > $TEMPFILE
		else
			echo "$PPPName connected" > $TEMPFILE
		fi
		
		
		ifconfig ppp0 | grep "inet addr" > $TMP1
		cut -f 2 -d":" $TMP1 > $TMP2
		pat=`cut -f 1 -d" " $TMP2`

		echo "$pat" >> $TEMPFILE

		pat=`cut -f 4 -d":" $TMP1`
		echo "$pat" >> $TEMPFILE
	else

	if [ -f /web/cosy ]; then
	        echo "$PPPName 연결안됨" > $TEMPFILE
	else
		echo "$PPPName disconnected" > $TEMPFILE
	fi

        echo "" >> $TEMPFILE
		echo "" >> $TEMPFILE
	fi
	echo "$HW_MAC" >> $TEMPFILE

	if [ "$dns_flag" = "0" ]; then
		pat=`head -n 1 /var/run/dns-tmp | tail -n 1 | cut -f 1 -d":" `
		echo "$pat" >> $TEMPFILE
    	pat=`head -n 2 /var/run/dns-tmp | tail -n 1 | cut -f 1 -d":" `
		echo "$pat" >> $TEMPFILE
	else
		if [ "$dns1" = "0.0.0.0" ]; then
			echo "" >> $TEMPFILE
		else
			echo $dns1 >> $TEMPFILE
		fi
		if [ "$dns2" = "0.0.0.0" ]; then
			echo "" >> $TEMPFILE
		else
			echo $dns2 >> $TEMPFILE
		fi
	fi

#--------------for second PPP --------------------
#--------------by AlexLien
	if [ -f /etc/ppp/link1 ]; then
		connect=1
	else
		connect=""
	fi

	ifconfig ppp1 | grep "inet addr" > $TMP1
	cut -f 2 -d":" $TMP1 > $TMP2
	pat=`cut -f 1 -d" " $TMP2`
	
		PPPName=PPPoE
		if [ "$MODEL" = "-D_7264Wn_" ]; then
			if [ "$ADSL_ENCAP" = "3" ] || [ "$ADSL_ENCAP" = "4" ]; then
				      PPPName=PPPoA
			fi
		fi	
	
	if [ "$connect" ]; then
		if [ -f /web/cosy ]; then
			echo "$PPPName 연결됨" > $TEMPFILE1
		else
			echo "$PPPName connected" > $TEMPFILE1
		fi

		ifconfig ppp1 | grep "inet addr" > $TMP1
		cut -f 2 -d":" $TMP1 > $TMP2
		pat=`cut -f 1 -d" " $TMP2`

		echo "$pat" >> $TEMPFILE1

		pat=`cut -f 4 -d":" $TMP1`
		echo "$pat" >> $TEMPFILE1
	else
		if [ -f /web/cosy ]; then
	 		echo "$PPPName 연결안됨" > $TEMPFILE1
		else
			echo "$PPPName disconnected" > $TEMPFILE1
		fi

        echo "" >> $TEMPFILE1
		echo "" >> $TEMPFILE1
	fi
	echo "$HW_MAC" >> $TEMPFILE1

	if [ "$dns_flag" = "0" ]; then
		pat=`head -n 1 /var/run/dns-tmp | tail -n 1 | cut -f 1 -d":" `
		echo "$pat" >> $TEMPFILE1
    	pat=`head -n 2 /var/run/dns-tmp | tail -n 1 | cut -f 1 -d":" `
		echo "$pat" >> $TEMPFILE1
	else
		if [ "$dns1" = "0.0.0.0" ]; then
			echo "" >> $TEMPFILE1
		else
			echo $dns1 >> $TEMPFILE1
		fi
		if [ "$dns2" = "0.0.0.0" ]; then
			echo "" >> $TEMPFILE1
		else
			echo $dns2 >> $TEMPFILE1
		fi
	fi
fi

if [ "$WAN_MODE" = "3" ]; then
	if [ -f /etc/ppp/link0 ]; then
		connect=1
	else
		connect=""
	fi
    if [ "$connect" ]; then
	if [ -f /web/cosy ]; then
		echo "PPTP 연결됨" > $TEMPFILE
	else
		echo "PPTP connected" > $TEMPFILE
	fi
	    ifconfig ppp0 | grep "inet addr" > $TMP1
	    cut -f 2 -d":" $TMP1 > $TMP2
	    pat=`cut -f 1 -d" " $TMP2`

	    echo "$pat" >> $TEMPFILE

		pat=`cut -f 4 -d":" $TMP1`
		echo "$pat" >> $TEMPFILE
    else
	if [ -f /web/cosy ]; then
	        echo "PPTP 연결안됨" > $TEMPFILE
	else
		echo "PPTP disconnected" > $TEMPFILE
	fi
        echo "" >> $TEMPFILE
        echo "" >> $TEMPFILE
    fi
    echo "$HW_MAC" >> $TEMPFILE

	if [ "$dns_flag" = "0" ]; then
		pat=`head -n 1 /var/run/dns-tmp | tail -n 1 | cut -f 1 -d":" `
		echo "$pat" >> $TEMPFILE
    	pat=`head -n 2 /var/run/dns-tmp | tail -n 1 | cut -f 1 -d":" `
		echo "$pat" >> $TEMPFILE
	else
		if [ "$dns1" = "0.0.0.0" ]; then
			echo "" >> $TEMPFILE
		else
			echo $dns1 >> $TEMPFILE
		fi
		if [ "$dns2" = "0.0.0.0" ]; then
			echo "" >> $TEMPFILE
		else
			echo $dns2 >> $TEMPFILE
		fi
	fi
fi


if [ "$WAN_MODE" = "6" ]; then
#----------------------------------Erwin Liao 19.08.03----------------------------------------
	if [ -f /etc/ppp/link0 ]; then
		connect=1
	else
		connect=""
	fi
#    connect=`ifconfig ppp0 | grep "inet addr"`
#---------------------------------------------------------------------------------
	if [ "$connect" ]; then
		if [ -f /web/cosy ]; then
			echo "L2TP 연결됨" > $TEMPFILE
		else
			echo "L2TP connected" > $TEMPFILE
		fi
	    ifconfig ppp0 | grep "inet addr" > $TMP1
	    cut -f 2 -d":" $TMP1 > $TMP2
	    pat=`cut -f 1 -d" " $TMP2`

	    echo "$pat" >> $TEMPFILE

		pat=`cut -f 4 -d":" $TMP1`
		echo "$pat" >> $TEMPFILE
    else
	if [ -f /web/cosy ]; then
	        echo "L2TP 연결안됨" > $TEMPFILE
	else
		echo "L2TP disconnected" > $TEMPFILE
	fi
        echo "" >> $TEMPFILE
        echo "" >> $TEMPFILE
    fi
    echo "$HW_MAC" >> $TEMPFILE

	if [ "$dns_flag" = "0" ]; then
		pat=`head -n 1 /var/run/dns-tmp | tail -n 1 | cut -f 1 -d":" `
		echo "$pat" >> $TEMPFILE
    	pat=`head -n 2 /var/run/dns-tmp | tail -n 1 | cut -f 1 -d":" `
		echo "$pat" >> $TEMPFILE
	else
		if [ "$dns1" = "0.0.0.0" ]; then
			echo "" >> $TEMPFILE
		else
			echo $dns1 >> $TEMPFILE
		fi
		if [ "$dns2" = "0.0.0.0" ]; then
			echo "" >> $TEMPFILE
		else
			echo $dns2 >> $TEMPFILE
		fi
	fi
fi
