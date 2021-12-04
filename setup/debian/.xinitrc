#!/bin/bash

[[ -f "$HOME/.Xresources" ]] && xrdb -merge -I "$HOME" "$HOME/.Xresources"

sh "$HOME/dotfiles/setup/debian/setup-monitors.sh"

[[ -f "$HOME/.xmodmaprc" ]] && xmodmap "$HOME/.xmodmaprc"

# start notification system in background
dunst &

# start status monitor in background
dwmstatus 2>&1 >/dev/null &

exec dwm
