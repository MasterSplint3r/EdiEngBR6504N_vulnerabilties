addr=`expr $1 + 1`
flash set HW_NIC0_ADDR 0050fcaf$1
flash set HW_WLAN_ADDR 0050fcaf$1
flash set HW_NIC1_ADDR 0050fcaf$addr

num=1
while [ $num -lt 15 ]
do
	flash set HW_TX_POWER_CCK $num $2
	flash set HW_TX_POWER_OFDM $num $3
	num=`expr $num + 1`
done
flash all | grep HW

