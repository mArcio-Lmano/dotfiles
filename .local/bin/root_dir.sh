#!bin/bash

size_it=`df -h | awk 'FNR == 4 {print $4}' | sed 's/.\b[0-9]G//'`
size_fl=`df -h | awk 'FNR == 4 {print $4}' | sed 's/\b[0-9].//' | sed 's/G//'`

if [ $size_fl -gt 0 ]
then
	used_fl=$((10-$size_fl))
	used_it=$((19-$size_it))
else
	used_fl=0
	used_it=$((20-$size_it))
fi

green=#a7d407
orange=#ffa500
red=#ff0000
color=$green

if [ $used_it -gt 17 ] && [ $used_it -lt 19 ]
then
	color=$orange
fi

if [ $used_it -gt 19 ]
then
	color=$red
fi

echo "<fc=$color>$used_it.$used_fl"G"</fc>"/20.0G

