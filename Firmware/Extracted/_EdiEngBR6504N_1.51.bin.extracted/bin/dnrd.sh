#!/bin/sh

###################

#include file
. /var/flash.inc

# DNS Setting
    
DNS_MODE=0
if [ "$DNS1" != '0.0.0.0' ]; then
    DNS_MODE=1
fi  
if [ "$DNS2" != '0.0.0.0' ]; then
    DNS_MODE=1
fi  
if [ "$DNS3" != '0.0.0.0' ]; then
    DNS_MODE=1
fi  

DNS_TEMP=/tmp/dns.tmp
DNS_LOG=/var/log/dns.log

dnrd -k 2> /dev/null
rm $DNS_TEMP 2> /dev/null
rm $DNS_LOG 2> /dev/null

rm /var/run/dns-tmp 2> /dev/null

#dnrd setting, dns -> /etc/resolv.conf
if [ $DNS_MODE = 1 ]; then

    echo "<<< User define DNS >>>" >> $DNS_LOG
    echo "DNS1= $DNS1" >> $DNS_LOG
    echo "DNS2= $DNS2" >> $DNS_LOG
    echo "DNS3= $DNS3" >> $DNS_LOG

    if [ "$DNS1" != '0.0.0.0' ]; then
        echo -n " -s $DNS1" >> $DNS_TEMP
    fi
    if [ "$DNS2" != '0.0.0.0' ]; then
        echo -n " -s $DNS2" >> $DNS_TEMP
    fi
    if [ "$DNS3" != '0.0.0.0' ]; then
        echo -n " -s $DNS3" >> $DNS_TEMP
    fi

    DNRD_COMMAND=`cat $DNS_TEMP`
    echo "Use command: $DNRD_COMMAND" >> $DNS_LOG

    if [ "$DNRD_COMMAND" != "" ]; then
        /bin/dnrd $DNRD_COMMAND
    fi
else

    echo "<<< Auto setting DNS >>>" >> $DNS_LOG

    cat /etc/resolv.conf | grep "nameserver" > /var/jj5
    cut -f 2 -d" " /var/jj5 > /var/jj6
    line=`cat /var/jj6 | wc -l`
    num=1
    while [ $num -le $line ];
    do
        pat=` head -n $num /var/jj6 | tail -n 1`
        if [ $line -eq 4 ]; then
        			if [ "$num" = "1" ]; then
        					pat="$pat:flets"
        			 elif [ "$num" = "2" ]; then
             		pat="$pat:194.210.220.in-addr.arpa"
             elif [ "$num" = "3" ]; then
             		pat="$pat:com"
        				fi        					
        fi
        echo -n " --server=$pat" >> /var/jj7
        echo "$pat" >> /var/run/dns-tmp
        num=`expr $num + 1`
    done
    echo "" >> /var/run/dns-tmp
    pat=` head -n $num /var/jj7 | tail -n 1`

    echo "Use command: $pat" >> $DNS_LOG

	if [ "$pat" != "" ]; then
	    dnrd $pat
	else	
	    dnrd -s 168.95.1.1
	fi

    rm /var/jj5 2> /dev/null
    rm /var/jj6 2> /dev/null
    rm /var/jj7 2> /dev/null
fi

