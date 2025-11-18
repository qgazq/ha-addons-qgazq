#!/usr/bin/with-contenv bashio

CONFIG_PATH=/data/options.json

LINE="$(bashio::config 'line')"

echo "Hello world!"

iptables -L -v -n

echo $LINE

