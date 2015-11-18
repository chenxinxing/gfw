#! /bin/bash

cat $1 | sort | uniq | grep "^[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}$" > /root/ip.sort

IFS="
"

for LINE in `cat /root/ip.sort`
do
	#echo $LINE | sed -ne "/^[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}$/p"
	ipset add setmefree $LINE -exist
done
rm /root/ip.sort
