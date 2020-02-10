#!/usr/bin/env bash

if [[ "$EUID" -ne 0 ]]; then
  echo "Please run as root"
  exit 1
fi

CURRENT_ADDR=`ifconfig en0 | grep ether | awk '{print $2}'`
NEW_ADDR=`openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'`

sudo ifconfig en0 ether $NEW_ADDR

echo "Changed $CURRENT_ADDR for $NEW_ADDR"
