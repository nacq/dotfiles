#!/usr/bin/env bash

TMUX_FILE=~/.tmux.conf
TMUX_TPM_DIR=~/.tmux/plugins/tpm/
VIMRC_FILE=~/.vimrc
BASH_PROFILE_FILE=~/.bash_profile

if [ -f $TMUX_FILE ]; then
    echo "tmux.conf already exists. Moving it to .tmux.conf.bak"
    rm ~/.tmux.conf.bak
    mv $TMUX_FILE ~/.tmux.conf.bak
fi

ln -s ~/dotfiles/.tmux.conf $TMUX_FILE

printf "Checking for Tmux Package Manager"

if [ -f $TMUX_TPM_DIR/tpm ]; then
        echo "Tmux Package Manager already installed!"
else
        echo "Cloning Tmux Package Manager"
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm/
fi

if [ -f $VIMRC_FILE ]; then
        echo "vimrc file already exists. Moving it to .vimrc.bak"
        rm ~/.vimrc.bak
        mv $VIMRC_FILE ~/.vimrc.bak
fi

ln -s ~/dotfiles/.vimrc $VIMRC_FILE

if [ -f $BASH_PROFILE_FILE ]; then
        echo "bash_profile file already exists. Moving it to .bash_profile.bak"
        rm ~/.bash_profile.bak
        mv $BASH_PROFILE_FILE ~/.bash_profile.bak
fi

ln -s ~/dotfiles/.bash_profile $BASH_PROFILE_FILE
