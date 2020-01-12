#!/usr/bin/env bash

# Example output of iostat -C
#
#              disk0       cpu    load average
#    KB/t  tps  MB/s  us sy id   1m   5m   15m
#    6.81  222  1.48   3  3 94  2.57 2.52 2.13

while true; do
  SLEEP_TIME=30
  # cpu load average 1m
  LOAD_AVERAGE=`iostat -C | awk 'FNR==3{ print $7 }'`

  echo "cpu: $LOAD_AVERAGE%";

  sleep $SLEEP_TIME;
done
