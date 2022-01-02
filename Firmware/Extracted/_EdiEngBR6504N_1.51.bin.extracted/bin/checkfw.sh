#!/bin/sh

eval `flash get FW_UP_OPT`

if [ "$FW_UP_OPT" -ge "48" ]; then
FW_UP_OPT=`expr $FW_UP_OPT - 48`
fi

if [ "`cat /tmp/RedirectForUpdate`" = "0" -a "$FW_UP_OPT" != "1" ]; then

	eval `flash get FW_LAST_TIME`
	TimeNow="`date +%s`"
	diffTime="`expr $TimeNow - $FW_LAST_TIME`"

	echo " $TimeNow"
	echo "-$FW_LAST_TIME"
	echo "----------------"
	echo " $diffTime                    $FW_UP_OPT"

	if [ "$FW_UP_OPT" = "0" ] || [ "$FW_UP_OPT" = "2" ] || [ "$FW_UP_OPT" = "3" -a "$diffTime" -ge "180000" ]; then

#		wget -P /tmp http://192.168.0.100/WL-183.xml
#		wget -P /tmp http://217.148.166.178/WL-183/WL-183.xml
		wget -q -P /tmp http://www.sitecom.com/upgrade/WL-183/WL-183.xml

		if [ "`cat /tmp/WL-183.xml`" != "" ]; then

			echo "Got valid version.xml."

			if [ `cat /tmp/WL-183.xml | grep "<version>" | cut -d ">" -f 2 | cut -d "<" -f 1` \> `cat /etc/version` ]; then   # <========== if new_ver != old_ver

				eval `flash get FW_SKIP_VER`

				if [ "$FW_SKIP_VER" != `cat /tmp/WL-183.xml | grep "<version>" | cut -d ">" -f 2 | cut -d "<" -f 1` ] || [ "$FW_UP_OPT" != "2" ]; then

					echo "Newver is not skipped or Option is not 2, ready to redirect."
					echo "========================================================"
						echo "1" > /tmp/RedirectForUpdate
						echo "0" > /tmp/pagenamewriten
						flash set FW_SHOW_UP_TIP 1
						if [ ! -f /tmp/foriptable ]; then
							iptables -A PREROUTING -t nat -i br0 -p tcp --dport 80 -j DNAT --to-destination `flash get IP_ADDR | cut -f 2 -d \'`:80
						fi
						echo "0" > /tmp/redirectedclient
						echo "1" > /tmp/foriptable
				fi
			else
				echo "No new version availible"
				echo "0" > /tmp/RedirectForUpdate
				flash set FW_SHOW_UP_TIP 0
			fi
		else
			echo "Got invalid version.xml"
			echo "0" > /tmp/RedirectForUpdate
			flash set FW_SHOW_UP_TIP 0
		fi
	else
		echo "0" > /tmp/RedirectForUpdate
	fi
fi
