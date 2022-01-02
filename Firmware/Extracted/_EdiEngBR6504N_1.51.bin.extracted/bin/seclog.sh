#!/bin/sh

SEC_FILE=/var/log/security
#include file
. /var/flash.inc
if [ "$#" = "1" ]; then
	if [ "$1" = "clean" ]; then
		rm -f $SEC_FILE 2> /dev/null
	fi
fi

