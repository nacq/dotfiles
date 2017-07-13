#!/usr/bin/env bash

TMUX_FILE=~/.tmux.conf
TMUX_TPM_DIR=~/.tmux/plugins/tpm/
VIMRC_FILE=~/.vimrc

if [ -f $TMUX_FILE ]; then
    printf "tmux.conf already exists. Moving it to .tmux.conf.bak"
    rm ~/.tmux.conf.bak
    mv $TMUX_FILE ~/.tmux.conf.bak
fi

ln -s ~/dotfiles/.tmux.conf $TMUX_FILE

printf "Checking for Tmux Package Manager"

if [ -f $TMUX_TPM_DIR/tpm ]; then
        printf "Tmux Package Manager already installed!"
else
        printf "Cloning Tmux Package Manager"
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm/
fi

if [ -f $VIMRC_FILE ]; then
        printf "vimrc file already exists. Moving it to .vimrc.bak"
        rm ~/.vimrc.bak
        mv $VIMRC_FILE ~/.vimrc.bak
fi

ln -s ~/dotfiles/.vimrc $VIMRC_FILE
