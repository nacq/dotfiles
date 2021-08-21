#!/bin/sh

xrandr --listproviders &> /dev/null &&
xrandr --setprovideroutputsource 1 0 &&
xrandr --setprovideroutputsource 2 0 &&
xrandr --setprovideroutputsource 3 0 &&
xrandr --setprovideroutputsource 4 0 &&

#
#   _ _ _ _ _
# |           |
# |           |   _ _ _ _ _ _ _ _ _ _ _
# |           | |                      |
# | DVI-I-1-1 | | DVI-I-2-2            |
# |           | |                      |
# |           | |                      |
# |           | | _ _ _ _ _ _ _ _ _ _ _|
# |           |   _ _ _ _ _ _
#  _ _ _ _ _ _   |           |
#                | eDP-1     |
#                | _ _ _ _ _ |
#
xrandr --output DVI-I-2-2 --auto --rotate normal --above eDP-1 &&
xrandr --output DVI-I-1-1 --auto --rotate right --left-of DVI-I-2-2
