#!/bin/bash

[[ -f $HOME/.xprofile ]] && source $HOME/.xprofile

xmodmap $HOME/.xmodmaprc

[[ -f $HOME/.Xresources ]] && xrdb -merge -I$HOME $HOME/.Xresources

sh ~/dotfiles/setup/debian/setup-monitors.sh

dunst &

exec i3
