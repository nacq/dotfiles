[[ -f $HOME/.xprofile ]] && source $HOME/.xprofile

# activate custom key table
[[ -f $HOME/.Xmodmap ]] && xmodmap $HOME/.Xmodmap

# start window manager
exec dwm
# start audio server
pulseaudio --start & # `--start is important, it will start the server only if it's not running`
