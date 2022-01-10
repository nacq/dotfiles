#!/bin/bash

# Example `amixer get Master` output
#
# Capabilities: pvolume pswitch pswitch-joined
# Playback channels: Front Left - Front Right
# Limits: Playback 0 - 65536
# Mono:
# Front Left: Playback 58982 [90%] [off]
# Front Right: Playback 58982 [90%] [off]

volume=$(amixer get Master | tail -n 1)

if [[ $(amixer get Master | tail -n 1) | grep off ]]; then
  echo 0%
else
  echo amixer get Master | tail -n 1 | awk '{ print $5 }'
fi

