#!/bin/bash

[[ -f "$HOME/.Xresources" ]] && xrdb -merge -I "$HOME" "$HOME/.Xresources"

# load keyboard conf
[[ -f "$HOME/.Xmodmap" ]] && xmodmap "$HOME/.Xmodmap"

# configure monitors
bash $HOME/dotfiles/scripts/monitors.sh

# wallpapo
[[ -f "$HOME/.fehbg" ]] && "$HOME/.fehbg" &

# start notification system
dunst &

# start status monitor
dwmstatus 2>&1 >/dev/null &

# start window manager
dwm
