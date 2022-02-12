#!/bin/bash

[[ -f "$HOME/.Xresources" ]] && xrdb -merge -I "$HOME" "$HOME/.Xresources"

bash $HOME/dotfiles/scripts/monitors.sh

[[ -f "$HOME/.Xmodmap" ]] && xmodmap "$HOME/.Xmodmap"

# start notification system in background
dunst &

# start status monitor in background
slstatus 2>&1 >/dev/null &

exec dwm
