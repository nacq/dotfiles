#!/usr/bin/env bash

GIT_CONFIG_FILE=~/.gitconfig
OHMYSZH_DIR=~/.oh-my-zsh
TMUX_FILE=~/.tmux.conf
TMUX_TPM_DIR=~/.tmux/plugins/tpm/
VIMRC_FILE=~/.vimrc
ZSH_FILE=~/.zshrc
VUNDLE=~/.vim/bundle/Vundle.vim
BASHRC=~/.bashrc

BLUE=$(tput setaf 4)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
UNDERLINE=$(tput smul)
BR="\n%s\n"

# brew does not like running things as sudo
if [ ! -x "$(command -v tmux)" ]; then
        printf "${BR}" "${RED}Tmux not installed... ${NORMAL}Installing it."
        brew install tmux reattach-to-user-namespace the_silver_searcher
fi

if [ "$EUID" -ne 0 ]; then
        printf ${BR} "${UNDERLINE}${RED}Please run as root.${NORMAL}"

        exit
fi

printf "${BR}${UNDERLINE} Installing and configuring dotfiles.${BR}"

if [ ! -x "$(command -v vim)" ]; then
        printf "${BR}" "${RED}Vim not installed... ${NORMAL}What world is this? Installing it."
        apt-get install -y vim
fi

if [ ! -x "$(command -v zsh)" ]; then
        printf ${BR} "${RED}zsh not installed. ${NORMAL}Installing it!"

        if [[ "$OSTYPE" == "linux-gnu" ]]; then
                apt-get install zsh
        elif [[ "$OSTYPE" == "darwin" ]]; then
                brew install zsh
        fi
fi

if [ ! -d $OHMYSZH_DIR ]; then
        printf ${BR} "${RED}oh my zsh not installed. ${NORMAL}Installing it!"
        sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -f $OHMYSZH_DIR/themes/dracula.zsh-theme ]; then
        TMP_DIR='temporal_directory_i_hope_this_does_not_exist'

        printf ${BR} "${GREEN}Installing dracula zsh theme.${NORMAL}"
        mkdir ${TMP_DIR}
        cd ${TMP_DIR}
        git clone https://github.com/dracula/zsh.git
        mv zsh/dracula.zsh-theme $OHMYSZH_DIR/themes/
        rm -rf ${TMP_DIR}
fi

if [ -f $ZSH_FILE ]; then
        printf ${BR} "${YELLOW}${ZSH_FILE} already exists. ${NORMAL}Moving it to ${ZSH_FILE}.bak"
        rm ~/.zshrc.bak
        mv $ZSH_FILE ~/.zshrc.bak
fi

ln -s ~/dotfiles/.zshrc $ZSH_FILE

if [ -f $BASHRC ]; then
        printf ${BR} "${YELLOW}${BASHRC} already exists. ${NORMAL}Moving it to ${BASHRC}.bak"
        rm ~/.bashrc.bak
        mv $BASHRC ~/.bashrc.bak
fi

ln -s ~/dotfiles/.bashrc $BASHRC

if [ -f $GIT_CONFIG_FILE ]; then
        printf ${BR} "${YELLOW}${GIT_CONFIG_FILE} already exists. ${NORMAL}Moving it to ${GIT_CONFIG_FILE}.bak"
        rm ~/.gitconfig.bak
        mv $GIT_CONFIG_FILE ~/.gitconfig.bak
fi

ln -s ~/dotfiles/.gitconfig $GIT_CONFIG_FILE

if [ -f $TMUX_FILE ]; then
    printf ${BR} "${YELLOW}${TMUX_FILE} already exists. ${NORMAL}Moving it to ${TMUX_FILE}.bak"
    rm ~/.tmux.conf.bak
    mv $TMUX_FILE ~/.tmux.conf.bak
fi

ln -s ~/dotfiles/.tmux.conf $TMUX_FILE

if [ -f $TMUX_TPM_DIR/tpm ]; then
        printf ${BR} "${GREEN}Tmux Package Manager already installed!"
        printf ${BR} "${NORMAL}Updating Tmux plugins"
        sh ~/.tmux/plugins/tpm/bin/update_plugins all
else
        printf ${BR} "${YELLOW}Cloning Tmux Package Manager"
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm/
        printf ${BR} "${NORMAL}Installing Tmux plugins"
        sh ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi

if [ -f $VIMRC_FILE ]; then
        printf ${BR} "${YELLOW}${VIMRC_FILE} file already exists. ${NORMAL}Moving it to ${VIMRC_FILE}.bak"
        rm ~/.vimrc.bak
        mv $VIMRC_FILE ~/.vimrc.bak
fi

if [ ! -d $VUNDLE ]; then
        printf ${BR} "${YELLOW} Vundle.vim not installed. ${NORMAL}Installing it."
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

ln -s ~/dotfiles/.vimrc $VIMRC_FILE

printf "${BR}${GREEN} DONE! ${BR}${NORMAL}"
