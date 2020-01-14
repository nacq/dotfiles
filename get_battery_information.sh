#!/usr/bin/env bash


# Example output of pmset -g batt
#
# Now drawing from 'AC Power'
# -InternalBattery-0 (id=3735651)        37%; charging; 2:16 remaining present: true

while true; do
  SLEEP_TIME=300
  STATUS=`pmset -g batt | awk 'FNR==2{ print $3, $5, $6 }'`
  PERCENTAGE=`echo $STATUS | awk '{ print $1 }' | sed 's/;//g'`

  # if battery full increase the sleep to 15 mins and show nothing
  if [ $PERCENTAGE == "100%" ]; then
    SLEEP_TIME=900
    STATUS=$PERCENTAGE
  fi

  echo "bat: $STATUS" | sed 's/;//g'

  # sleep 5 mins
  sleep $SLEEP_TIME;
done
