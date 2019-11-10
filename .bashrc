# exec zsh by default
if [ -t 1 ]; then
    exec zsh
fi
