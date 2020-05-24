#!/usr/bin/env bash
#
# Style guide: https://google.github.io/styleguide/shell.xml

GIT_CONFIG_FILE=$HOME/.gitconfig
OHMYSZH_DIR=$HOME/.oh-my-zsh
TMUX_FILE=$HOME/.tmux.conf
TMUX_TPM_DIR=$HOME/.tmux/plugins/tpm/
VIMRC_FILE=$HOME/.vimrc
ZSH_FILE=$HOME/.zshrc
PLUGGED=$HOME/.vim/plugged
BASHRC=$HOME/.bashrc
NVIM_CONFIG_DIR=$HOME/.config/nvim

PACKAGES=(
  # these two needed by ycm
  "cmake"
  "python3-dev"
  "curl"
  "fzf"
  "nvim"
  "silversearcher-ag"
  "tmux"
  "zsh"
)

log() {
  echo -e "\e[92m >>>\e[0m" $1
}

osx_install() {
  _echo "MacOS detected" $GREEN $UNDERLINE

  if [[ ! -x "$(command -v nvim)" ]]; then
    _echo " > Installing Neovim" $GREEN
    brew install neovim
  else
    _echo " > Neovim installed" $YELLOW
  fi

  if [[ ! -x "$(command -v tmux)" ]]; then
    _echo " > Installing Tmux" $GREEN
    brew install tmux
  else
    _echo " > Tmux installed" $YELLOW
  fi

  if [[ ! -x "$(command -v zsh)" ]]; then
    _echo " > Installing Zsh" $GREEN
    brew install zsh
  else
    _echo " > Zsh installed" $YELLOW
  fi

  if [[ ! -x "$(which fzf)" ]]; then
    _echo " > Installing Fzf" $GREEN
    brew install fzf
  else
    _echo " > Fzf installed" $YELLOW
  fi

  commons
}

linux_install() {
  # root check
  # if [[ "$EUID" -ne 0 ]]; then
    # echo " >>> Please run as root"
    # exit 1
  # fi

  for package in "${PACKAGES[@]}"; do
    # meh
    [[ $package == "silversearcher-ag" ]] && package="ag"
    [[ -x "$(command which $package)" ]] || sudo apt-get install -y $package && log "$package installed"
  done

  # cleanup dependencies not loger needed
  sudo apt-get autoremove -y

  commons
}

commons() {
  if [[ -f $BASHRC ]]; then
    [[ -f $BASHRC.bak ]] && rm $HOME/.bashrc.bak && mv $BASHRC $HOME/.bashrc.bak
  fi

  ln -sf $HOME/dotfiles/.bashrc $BASHRC

  if [[ -f $GIT_CONFIG_FILE ]]; then
    [[ -f $GIT_CONFIG_FILE.bak ]] && rm $HOME/.gitconfig.bak && mv $GIT_CONFIG_FILE $HOME/.gitconfig.bak
  fi

  ln -sf $HOME/dotfiles/.gitconfig $GIT_CONFIG_FILE

  if [[ -f $TMUX_FILE ]]; then
    [[ -f $TMUX_FILE.bak ]] && rm $HOME/.tmux.conf.bak &&  mv $TMUX_FILE $HOME/.tmux.conf.bak
  fi

  ln -sf $HOME/dotfiles/.tmux.conf $TMUX_FILE

  # TODO: investigate, this var is needed by tpm to install plugins but it's not defined at this point
  # this is the installation dir of the plugins
  export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins"
  if [[ -f $TMUX_TPM_DIR/tpm ]]; then
    $HOME/.tmux/plugins/tpm/bin/update_plugins all
  else
    log "Installing tmux plugin manager"
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm/
    $HOME/.tmux/plugins/tpm/bin/install_plugins
  fi
  unset TMUX_PLUGIN_MANAGER_PATH

  if [[ -f $VIMRC_FILE ]]; then
    [[ -f $VIMRC_FILE.bak ]] && rm $HOME/.vimrc.bak && mv $VIMRC_FILE $HOME/.vimrc.bak
  fi

  ln -sf $HOME/dotfiles/.vimrc $VIMRC_FILE

  # nvim config
  if [[ ! -d $HOME/.config ]]; then
    mkdir $HOME/.config
  else
    [[ -d $HOME/.config/nvim ]] && rm -rf $HOME/.config/nvim
  fi

  ln -sf $HOME/dotfiles/.config/nvim $HOME/.config/nvim

  [[ ! -d $PLUGGED ]] && curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && " >>> vim-plug installed"

  # # install vim plugins using Vundle
  # # -c flag runs command before vim starts up
  nvim -c "PlugInstall" -c "qa!"
  nvim -c "PlugUpdate" -c "qa!"

  # install Typescript support
  python3 $PLUGGED/YouCompleteMe/install.py --ts-completer

  # keep zsh install to the last bc it asks for user input
  [[ -f $ZSH_FILE ]] && [[ -f $ZSH_FILE.bak ]] && rm $HOME/.zshrc.bak && mv $ZSH_FILE $HOME/.zshrc.bak
  ln -sf $HOME/dotfiles/.zshrc $ZSH_FILE

  log "The following symbolic links were created:"
  cd $HOME && ls -la | grep "\->" | grep dotfiles | grep -v bak

  # this as the last step bc it hangs the execution of the script
  [[ ! -d $OHMYSZH_DIR ]] && sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

linux_rollback() {
  [[ $OSTYPE != "linux-gnu" ]] && exit 1

  # remove all files and dirs created with this script
  rm -rf $GIT_CONFIG_FILE $TMUX_FILE $TMUX_TPM_DIR $VIMRC_FILE $ZSH_FILE $PLUGGED $BASHRC $NVIM_CONFIG_DIR \
    $HOME/.tmux

  for package in "${PACKAGES[@]}"; do
    sudo apt-get remove -y $package
  done

  # cleanup dependencies not loger needed
  sudo apt-get autoremove -y
}

prompt_user() {
  log "What you wanna do? (install, rollback):"
  read ANSWER

  case $ANSWER in
    install) start_install ;;
    rollback) linux_rollback ;;
    **) prompt_user ;;
  esac
}

start_install() {
  case $OSTYPE in
    darwin) osx_install ;;
    darwin18) osx_install ;;
    darwin19) osx_install ;;
    linux-gnu) linux_install ;;
    **) log "Unsupported OS ${OSTYPE}" && exit 1 ;;
  esac

  log "Done! Restart the terminal" && exit 0
}

main() {
  prompt_user
}

main
