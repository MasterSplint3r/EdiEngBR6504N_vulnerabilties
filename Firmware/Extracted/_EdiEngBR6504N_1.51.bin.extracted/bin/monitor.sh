#!/bin/sh

echo "LED OFF" > /dev/USB_LED0
echo "LED OFF" > /dev/USB_LED1

while [ 1 ]
do
	sw1=`cat /dev/switch`
	if [ $sw1 = 0 ] ; then
		sleep 1
		sw2=`cat /dev/switch`
		if [ $sw2 = 0 ] ; then
			echo "led blink 1000" > /dev/PowerLED
			sleep 1
			sw3=`cat /dev/switch`
			if [ $sw3 = 0 ] ; then
				sleep 1
				sw4=`cat /dev/switch`
				if [ $sw4 = 0 ] ; then
					sleep 1
					sw5=`cat /dev/switch`
					if [ $sw5 = 0 ] ; then
						echo "led blink 50" > /dev/PowerLED
						echo "Reset to Factory Default!!!"
						/bin/flash default
					fi
				fi
			fi
			/sbin/reboot
		fi
	fi
done
