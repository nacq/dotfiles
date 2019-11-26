#!/usr/bin/env bash


# Example output of pmset -g batt
#
# Now drawing from 'AC Power'
# -InternalBattery-0 (id=3735651)        37%; charging; 2:16 remaining present: true

while true; do
  pmset -g batt | awk 'FNR==2{ print $3, $5, $6 }'

  # sleep 5 mins
  sleep 300;
done
