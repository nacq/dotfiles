#!/bin/sh

#
#   _ _ _ _ _
# |           |
# |           |   _ _ _ _ _ _ _ _ _ _ _
# |           | |                      |
# | HDMI-2    | | DP-1                 |
# |           | |                      |
# |           | |                      |
# |           | | _ _ _ _ _ _ _ _ _ _ _|
# |           |   _ _ _ _ _ _
#  _ _ _ _ _ _   |           |
#                | eDP-1     |
#                | _ _ _ _ _ |
#
#
# This script is executed by a udev rule after plugging/unplugging
# a monitor and by .xinitrc.
#

xrandr --output eDP-1 --auto --rotate normal \
  --output DP-1 --auto --rotate normal --above eDP-1 \
  --output HDMI-2 --auto --rotate normal --left-of DP-1

logger "scripts/monitor.sh executed"
