#!Bin/sh

vol=`amixer get Master | awk '/%/ {print $6}' | awk 'NR==1 {print}' | sed 's/[][]//g'`

if [ "$vol" == "on" ] || [ "$vol" == "off"]; then
	if [ "$vol" == "on" ]; then
		echo ""
	else
		echo ""
	fi
else
	vol=`amixer get Master | awk '/%/ {print $5}' | awk 'NR==1 {print}' | sed 's/[][]//g'`
	if [ "$vol" == "on" ]; then
		echo ""
	else
		echo ""
	fi
fi
