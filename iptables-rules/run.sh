#!/usr/bin/with-contenv bashio

CONFIG_PATH=/data/options.json

LINE="$(bashio::config 'line')"
echo $LINE

echo "Current rules"
echo "-------------"
echo iptables -L -v -n
iptables -L -v -n
echo "-------------"
echo iptables -L -v -n -t nat
iptables -L -v -n -t nat
echo "-------------"

echo Finding NTP host
NTPHOST=""
while [ -z $NTPHOST ] ; do
	NTPHOST=$(iptables -L DOCKER -v -n -t nat | grep :123 | cut -d":" -f3)
	echo Found $NTPHOST
	sleep 5
done
echo "-------------"

echo Adding rule
echo iptables -t nat -I PREROUTING 2 -i wlan0 -p udp --dport 123 -j DNAT --to-destination $NTPHOST:123
iptables -t nat -I PREROUTING 2 -i wlan0 -p udp --dport 123 -j DNAT --to-destination $NTPHOST:123
echo "-------------"

echo Adding logging rules
iptables -A FORWARD -i wlan0 -j LOG
iptables -A POSTROUTING -o end0 -s 192.168.12.0/24 -j LOG -t nat
echo "-------------"

echo "Post rules"
echo "-------------"
echo iptables -L -v -n
iptables -L -v -n
echo "-------------"
echo iptables -L -v -n -t nat
iptables -L -v -n -t nat
echo "-------------"

