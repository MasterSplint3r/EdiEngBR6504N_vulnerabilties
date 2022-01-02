#!/bin/sh
#  $1 = 0/1 : disable/enable
#  $2       : interface

#include file
. /var/flash.inc

echo " - Port Scan: $1"

### delete old ###

# NMAP FIN/URG/PSH
iptables -D INPUT -i $2 -p tcp --tcp-flags ALL FIN,URG,PSH -j DROP 2> /dev/null

# Xmas tree
iptables -D INPUT -i $2 -p tcp --tcp-flags ALL ALL -j DROP 2> /dev/null

# Another Xmas tree
iptables -D INPUT -i $2 -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP 2> /dev/null

# Null scan
iptables -D INPUT -i $2 -p tcp --tcp-flags ALL NONE -j DROP 2> /dev/null

# SYN/RST
iptables -D INPUT -i $2 -p tcp --tcp-flags SYN,RST SYN,RST -j DROP 2> /dev/null

# SYN/FIN
iptables -D INPUT -i $2 -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP 2> /dev/null

# SYN unreachable port
iptables -D OUTPUT -p tcp --tcp-flags RST RST -j DROP 2> /dev/null
iptables -D INPUT -i $2 -p tcp --dport 53 -j DROP 2> /dev/null

if [ "$1" = "1" ]; then	
	
	i=0;
	TMP=a

	SCAN_TMP=`echo $SCAN_NUM | cut -f2 -d=`
	
	while [ "$TMP" != "" ]; do
	
		i=`expr $i + 1`
		
		OLD=$TMP
		TMP=`echo $SCAN_TMP | cut -f$i -d ','`

	    if [ "$TMP" = "$OLD" ]; then
	        break
	    fi

		case "$TMP" in
			"nmap")
				# NMAP FIN/URG/PSH
#				echo "nmap"
				iptables -A INPUT -i $2 -p tcp --tcp-flags ALL FIN,URG,PSH -j DROP
				;;
			"xmastree")
				# Xmas tree
#				echo "xmastree"
				iptables -A INPUT -i $2 -p tcp --tcp-flags ALL ALL -j DROP
				;;
			"axmastree")
				# Another Xmas tree
#				echo "axmastree"
				iptables -A INPUT -i $2 -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP
				;;
			"nullscan")
				# Null scan
#				echo "nullscan"
				iptables -A INPUT -i $2 -p tcp --tcp-flags ALL NONE -j DROP
				;;
			"synrst")
				# SYN/RST
#				echo "synrst"
				iptables -A INPUT -i $2 -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
				;;
			"synfin")
				# SYN/FIN
#				echo "synfin"
				iptables -A INPUT -i $2 -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP
				;;
			"synouport")
			    # SYN unreachable port
#				echo "synouport"
			    iptables -A OUTPUT -p tcp --tcp-flags RST RST -j DROP
			    iptables -A INPUT -i $2 -p tcp --dport 53 -j DROP
				;;
		esac
	done
fi
