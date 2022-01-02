yearVal=`date +%Y`
monthVal=`date +%m`
dateVal=`date +%d`
hourVal=`date +%H`
minVal=`date +%M`
secVal=`date +%S`
monthVal=`expr $monthVal - 1`
echo "$yearVal,$monthVal,$dateVal,$hourVal,$minVal,$secVal" > /var/time.tmp

