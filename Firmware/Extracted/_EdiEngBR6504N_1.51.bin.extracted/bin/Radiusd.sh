#!/bin/sh
. /var/flash.inc	# add Erwin
# ********** Setting **********

# RADIUS Server database's pth
RADDB_PATH=/etc/raddb

# user database
USERS=$RADDB_PATH/users

# client database
CLIENTS=$RADDB_PATH/clients

# RADIUS Server app
RADIUSD=/sbin/radiusd

# RADIUS Server command
RADIUSD_FLAGS="-fs"

# **********   End   **********


# ********** SCRIPT Code **********

if [ "$RSER_ENABLED" = '1' ] ; then
	case "$1" in
		start)
			echo "Radiusd starting..."
#			radiusd_start
#********************************************************************************************
	# delete users
	echo "Delete old user database..."
	rm -f $USERS 2> /dev/null

	# create users and
	echo "Create new user database..."
	touch $USERS
	
	if [ $RSER_USR_TBL_NUM -gt 0 ] && [ $RSER_ENABLED -gt 0 ]; then
		num=1
		while [ $num -le $RSER_USR_TBL_NUM ];
		do

		eval "rser_usr="\$RSER_USR_TBL$num""
		usr_name=`echo $rser_usr | cut -f1 -d,`
		usr_pass=`echo $rser_usr | cut -f2 -d,`
		num=`expr $num + 1`

		echo "$usr_name Auth-Type = EAP, User-Password == $usr_pass" >> $USERS
		echo "" >> $USERS
	
		done
	fi
    # delete clients
    echo "Delete old clients database..."
    rm -f $CLIENTS 2> /dev/null

    # create clients
    echo "Create new client database..."
    echo "$IP_ADDR AP1234" > $CLIENTS
	
	if [ $RSER_CLT_TBL_NUM -gt 0 ] && [ $RSER_ENABLED -gt 0 ]; then
		num=1
		while [ $num -le $RSER_CLT_TBL_NUM ];
		do

		eval "rser_clt="\$RSER_CLT_TBL$num""
		clt_ip=`echo $rser_clt | cut -f1 -d,`
		clt_pass=`echo $rser_clt | cut -f2 -d,`
		num=`expr $num + 1`

		echo "$clt_ip $clt_pass" >> $CLIENTS
		echo "" >> $CLIENTS
	
		done
	fi
	
	echo "Start running RADIUS server..."
	$RADIUSD $RADIUSD_FLAGS &
#*******************************************************************************************
			echo
			;;
		stop)
			echo "Radiusd stopping..."
#			radiusd_stop
			killall radiusd
			echo
			;;
		restart)
			$0 stop
			$0 start
			;;
		*)
			echo "Usage: $0 [start|stop|restart IP SECRET]"
			;;
	esac
else
#	radiusd_stop
	killall radiusd
	echo "RADIUS server disable !!"
fi

# ********** SCRIPT Code END **********
