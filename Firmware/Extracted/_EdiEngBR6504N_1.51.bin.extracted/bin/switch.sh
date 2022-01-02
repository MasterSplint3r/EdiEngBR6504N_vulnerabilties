#!/bin/sh

. /var/flash.inc

DOWN=0

if [ "$NETWORK_TYPE" = "0" ]; then
	echo "led off" > /dev/led_mode
else
	if [ "$NETWORK_TYPE" = "1" ]; then
		echo "led on" > /dev/led_mode
	fi
fi

while [ 1 ]; do

	PRESS=`cat /dev/switch`
	
	if [ "$DOWN" = "0" ]; then
		if [ "$PRESS" = "0" ]; then
			if [ "$NETWORK_TYPE" = "1" ]; then
				echo "led off" > /dev/led_mode
				/bin/flash set NETWORK_TYPE 0
				/bin/flash set AP_MODE 2
				killall webs 2> /dev/null
				webs &
				/bin/init.sh ap all
			else
				if [ "$NETWORK_TYPE" = "0" ]; then
					echo "led on" > /dev/led_mode
					/bin/flash set NETWORK_TYPE 1
					/bin/flash set AP_MODE 1
					killall webs 2> /dev/null
					webs &
					/bin/init.sh ap all
				fi
			fi
			DOWN=1
		fi
	else
		if [ "$PRESS" = "1" ]; then
			DOWN=0
		fi
	fi
	
	sleep 1
done
