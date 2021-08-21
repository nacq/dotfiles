#!/bin/bash

[[ -f $HOME/.xprofile ]] && source $HOME/.xprofile

[[ -f $HOME/.Xresources ]] && xrdb -merge -I$HOME $HOME/.Xresources

xmodmap $HOME/.xmodmaprc

sh ~/dotfiles/setup/debian/setup-monitors.sh

dunst &

exec i3
