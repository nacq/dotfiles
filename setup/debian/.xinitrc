#!/bin/bash

[[ -f $HOME/.xprofile ]] && source $HOME/.xprofile

[[ -f $HOME/.Xresources ]] && xrdb -merge -I$HOME $HOME/.Xresources

exec i3
