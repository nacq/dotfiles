#!/usr/bin/env bash
#
# Style guide: https://google.github.io/styleguide/shell.xml

GIT_CONFIG_FILE=$HOME/.gitconfig
OHMYSZH_DIR=$HOME/.oh-my-zsh
TMUX_FILE=$HOME/.tmux.conf
TMUX_TPM_DIR=$HOME/.tmux/plugins/tpm/
VIMRC_FILE=$HOME/.vimrc
ZSH_FILE=$HOME/.zshrc
VUNDLE=$HOME/.vim/bundle/Vundle.vim
BASHRC=$HOME/.bashrc

BLUE=$(tput setaf 4)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
UNDERLINE=$(tput smul)
BR="\n"

# $1 message
# $2 color
# $3 underlined
_echo() {
  message="\n${2}${1}"

  if [[ $3 ]]; then
    message="$3$message"
  fi

  echo -e "$message${NORMAL}"
}

osx_install() {
  _echo "MacOS detected" $GREEN $UNDERLINE

  if [[ ! -x "$(command -v tmux)" ]]; then
    _echo " > Installing Tmux" $GREEN
    brew install tmux
  fi

  if [[ ! -x "$(command -v zsh)" ]]; then
    _echo " > Installing Zsh" $GREEN
    brew install zsh
  fi
}

linux_install() {
  _echo "Linux detected" $GREEN

  if [[ ! -x "$(command -v tmux)" ]]; then
    _echo " > Installing Tmux" $GREEN
    apt-get install -y tmux
  fi

  if [[ ! -x "$(command -v curl)" ]]; then
    _echo " > Installing Curl" $GREEN
    apt-get install -y curl
  fi

  if [[ ! -x "$(command -v zsh)" ]]; then
    _echo " > Installing Zsh" $GREEN
    apt-get install zsh -Y
  fi
}

commons() {
  if [[ ! -d $OHMYSZH_DIR ]]; then
    _echo " > Installing Oh My Zsh" $GREEN
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi

  if [[ -f $ZSH_FILE ]]; then
    _echo " >> ${ZSH_FILE} already exists. Moving it to ${ZSH_FILE}.bak" $YELLOW
    if [[ -f $ZSH_FILE.bak ]]; then
      rm $HOME/.zshrc.bak
    fi
    mv $ZSH_FILE $HOME/.zshrc.bak
  fi

  ln -s $HOME/dotfiles/.zshrc $ZSH_FILE

  if [[ -f $BASHRC ]]; then
    _echo " >> ${BASHRC} already exists. Moving it to ${BASHRC}.bak" $YELLOW
    if [[ -f $BASHRC.bak ]]; then
      rm $HOME/.bashrc.bak
    fi
    mv $BASHRC $HOME/.bashrc.bak
  fi

  ln -s $HOME/dotfiles/.bashrc $BASHRC

  if [[ -f $GIT_CONFIG_FILE ]]; then
    _echo " >> ${GIT_CONFIG_FILE} already exists. Moving it to ${GIT_CONFIG_FILE}.bak" $YELLOW
    if [[ -f $GIT_CONFIG_FILE.bak ]]; then
      rm $HOME/.gitconfig.bak
    fi
    mv $GIT_CONFIG_FILE $HOME/.gitconfig.bak
  fi

  ln -s $HOME/dotfiles/.gitconfig $GIT_CONFIG_FILE

  if [[ -f $TMUX_FILE ]]; then
    _echo " >> ${TMUX_FILE} already exists. Moving it to ${TMUX_FILE}.bak" $YELLOW
    if [[ -f $TMUX_FILE.bak ]]; then
      rm $HOME/.tmux.conf.bak
    fi
    mv $TMUX_FILE $HOME/.tmux.conf.bak
  fi

  ln -s $HOME/dotfiles/.tmux.conf $TMUX_FILE

  if [[ -f $TMUX_TPM_DIR/tpm ]]; then
    _echo " >> Updating Tmux plugins" $YELLOW
    sh $HOME/.tmux/plugins/tpm/bin/update_plugins all
  else
    _echo " >> Installing Tmux Package Manager and plugins" $GREEN
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm/
    sh $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh
  fi

  if [[ -f $VIMRC_FILE ]]; then
    _echo " >> ${VIMRC_FILE} already exists. Moving it to ${VIMRC_FILE}.bak" $YELLOW
    if [[ -f $VIMRC_FILE.bak ]]; then
      rm $HOME/.vimrc.bak
    fi
    mv $VIMRC_FILE $HOME/.vimrc.bak
  fi

  ln -s $HOME/dotfiles/.vimrc $VIMRC_FILE

  if [[ ! -d $VUNDLE ]]; then
    _echo " >> Installing Vundle, vim plugin manager." $GREEN
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
  fi

  # # install vim plugins using Vundle
  # # -c flag runs command before vim starts up
  vim -c "PluginInstall" -c "qa!"

  _echo " > The following symbolic links were created:" $GREEN $UNDERLINE
  cd $HOME && ls -la | grep "\->" | grep dotfiles | grep -v bak
}

main() {
  if [[ "$EUID" -ne 0 ]]; then
    _echo "Please run as root" $RED $UNDERLINE
    exit 1
  fi

  case $OSTYPE in
    darwin18) osx_install ;;
    darwin) osx_install ;;
    linux-gnu) linux_install ;;
    **)
      _echo "Unsupported OS ${OSTYPE}" $RED
      exit 1
      ;;
  esac

  commons

  _echo "DONE!" $GREEN $UNDERLINE
}

main
