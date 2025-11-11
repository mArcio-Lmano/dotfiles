#!bin/bash

vol=`amixer get Master | awk '/%/ {print $5}' | awk 'NR==1 {print}' | sed 's/[][]//g'`

if [ "$vol" == "on" ] || [ "$vol" == "off" ]; then
	vol=`amixer get Master | awk '/%/ {print $4}' | awk 'NR==1 {print}' | sed 's/[][]//g'`
fi

echo "$vol"

