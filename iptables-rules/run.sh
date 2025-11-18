#!/usr/bin/with-contenv bashio

CONFIG_PATH=/data/options.json

LINE="$(bashio::config 'line')"

echo "Hello world!"

iptables -L -v -n
iptables -L -v -n -t nat

echo $LINE

NTPHOST=""

while [ -z $NTPHOST ] ; do
NTPHOST=$(iptables -L DOCKER -v -n -t nat | grep :123 | cut -d":" -f3)
sleep 5
done

iptables -t nat -I PREROUTING 2 -i wlan0 -p udp --dport 123 -j DNAT --to-destination $NTPHOST:123

iptables -A FORWARD -i wlan0 -j LOG
iptables -A POSTROUTING -o end0 -s 192.168.12.0/24 -j LOG -t nat

iptables -L -v -n
iptables -L -v -n -t nat

