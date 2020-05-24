#!/usr/bin/env bash
#
# Style guide: https://google.github.io/styleguide/shell.xml

OHMYSZH_DIR=$HOME/.oh-my-zsh
TMUX_TPM_DIR=$HOME/.tmux/plugins/tpm/
PLUGGED=$HOME/.vim/plugged
NVIM_CONFIG_DIR=$HOME/.config/nvim

FILES=(
  ".gitconfig"
  ".tmux.conf"
  ".vimrc"
  ".zshrc"
  ".bashrc"
)
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
MACOS_PACKAGES=(
  "neovim"
  "tmux"
  "fzf"
  "the_silver_searcher"
)

log() {
  echo -e "\e[92m >>>\e[0m" $1
}

osx_install() {
  for package in "${MACOS_PACKAGES[@]}"; do
    [[ $package == "the_silver_searcher" ]] && package="ag"
    [[ -x "$(command which $package)" ]] || brew install $package && log "$package installed"
  done

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

link_files() {
  for file in "${FILES[@]}"; do
    if [[ -f $file ]]; then
      [[ -f $file.bak ]] && rm $HOME/$file.bak && mv $file $HOME/$file.bak
    fi

    ln -sf $HOME/dotfiles/$file $HOME/$file
  done
}

commons() {
  link_files

  [[ ! -d $OHMYSZH_DIR ]] && sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  # installation dir of the plugins
  #this var is needed by tpm to install plugins but it's not defined at this point
  export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins"
  if [[ -f $TMUX_TPM_DIR/tpm ]]; then
    $HOME/.tmux/plugins/tpm/bin/update_plugins all
    log "tpm installed"
  else
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm/
    log "tpm installed"
    $HOME/.tmux/plugins/tpm/bin/install_plugins
  fi
  unset TMUX_PLUGIN_MANAGER_PATH

  # nvim config
  if [[ ! -d $HOME/.config ]]; then
    mkdir $HOME/.config
  else
    [[ -d $HOME/.config/nvim ]] && rm -rf $HOME/.config/nvim
  fi

  ln -sf $HOME/dotfiles/.config/nvim $HOME/.config/nvim

  [[ ! -d $PLUGGED ]] && curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && log "vim-plug installed"

  # # install vim plugins using Vundle
  # # -c flag runs command before vim starts up
  nvim -c "PlugInstall" -c "qa!"
  nvim -c "PlugUpdate" -c "qa!"

  # install Typescript support
  python3 $PLUGGED/YouCompleteMe/install.py --ts-completer

  log "The following symbolic links were created:"
  cd $HOME && ls -la | grep "\->" | grep dotfiles | grep -v bak
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
