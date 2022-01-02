#!/bin/sh
#
# script file to start vlan passthrough.
# Kyle 2008/02/25

. /var/flash.inc
#MODE=`cat /web/mode`
. /web/mode

	OLD_TAG=`cat /var/oldTag.var`
		if [ "$OLD_TAG" != "$TAG_VLAN_ID" ] || [ "$TAG_VLAN_ENABLE" != "1" ]; then

			brctl delif br1 "br0.$OLD_TAG"
			brctl delif br1 "eth1.$OLD_TAG"
			
			ifconfig "br0.$OLD_TAG" down
			ifconfig "eth1.$OLD_TAG" down
			
			vconfig rem "br0.$OLD_TAG"
			vconfig rem "eth1.$OLD_TAG"
			
			
			ifconfig br1 down
			brctl delbr br1
			rm -f /var/oldTag.var
		fi	
	



if [ "$TAG_VLAN_ENABLE" = "1" ]; then
	
vconfig add br0 $TAG_VLAN_ID
vconfig add eth1 $TAG_VLAN_ID

ifconfig "br0.$TAG_VLAN_ID" up
ifconfig "eth1.$TAG_VLAN_ID" up

brctl addbr br1
ifconfig br1 up

brctl addif br1 "br0.$TAG_VLAN_ID"
brctl addif br1 "eth1.$TAG_VLAN_ID"

echo $TAG_VLAN_ID > /var/oldTag.var

fi

#vconfig add br0 1
#vconfig add eth1 1
#brctl addbr br1

#ifconfig br0.1 up

#ifconfig br1 up

#brctl addif br1 br0.1 
#brctl addif br1 eth1.1
