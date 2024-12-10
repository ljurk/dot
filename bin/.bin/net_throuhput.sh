#!/bin/bash

if [ -z "$1" ]; then
    echo "usage: net_throughput.sh IFACE"
    exit 1
fi
IFACE="$1"
INTERVAL=1

while true; do
    RX_BYTES1=$(cat /proc/net/dev | grep $IFACE | awk '{print $2}')
    TX_BYTES1=$(cat /proc/net/dev | grep $IFACE | awk '{print $10}')
    sleep $INTERVAL
    RX_BYTES2=$(cat /proc/net/dev | grep $IFACE | awk '{print $2}')
    TX_BYTES2=$(cat /proc/net/dev | grep $IFACE | awk '{print $10}')
    RX_RATE=$((($RX_BYTES2 - $RX_BYTES1) / $INTERVAL))
    TX_RATE=$((($TX_BYTES2 - $TX_BYTES1) / $INTERVAL))
    RX_MBPS=$(echo "$RX_RATE * 8/ 1024 / 1024" | bc)
    TX_MBPS=$(echo "$TX_RATE * 8/ 1024 / 1024" | bc)
    echo "RX: ${RX_MBPS} Mbit/s, TX: ${TX_MBPS} Mbit/s"
done
