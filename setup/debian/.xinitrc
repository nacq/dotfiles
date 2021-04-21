#!/bin/bash

[[ -f $HOME/.xprofile ]] && source $HOME/.xprofile

[[ -f $HOME/.Xresources ]] && xrdb -merge -I$HOME $HOME/.Xresources

# if no keyboard connected load xmodmaprc
lsusb -v 2>/dev/null | grep HHKB || xmodmap $HOME/.xmodmaprc

exec i3
