#!/bin/bash

[[ -f "$HOME/.Xresources" ]] && xrdb -merge -I "$HOME" "$HOME/.Xresources"

# load keyboard conf
[[ -f "$HOME/.Xmodmap" ]] && xmodmap "$HOME/.Xmodmap"

# configure monitors
bash $HOME/dotfiles/scripts/monitors.sh

# start notification system
dunst &

# start status monitor
slstatus 2>&1 >/dev/null &

# start window manager
dwm
