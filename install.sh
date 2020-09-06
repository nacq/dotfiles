#!/usr/bin/env bash
#
# Style guide: https://google.github.io/styleguide/shell.xml

OHMYSZH_DIR=$HOME/.oh-my-zsh
TMUX_TPM_DIR=$HOME/.tmux/plugins/tpm/
PLUGGED=$HOME/.vim/plugged
NVIM_CONFIG_DIR=$HOME/.config/nvim

path=$(pwd)

FILES=(
  ".gitconfig"
  ".tmux.conf"
  ".vimrc"
  ".zshrc"
  ".bashrc"
)
DIRS=(
  ".gnupg"
)
PACKAGES=(
  # these two needed by ycm
  "cmake"
  "python3-dev"
  "curl"
  "fzf"
  # not "nvim" https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu
  "neovim"
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
  echo -e "\033[92m >>>\033[0m" $1
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

create_dirs() {
  for dir in "${DIRS[@]}"; do
    ls -a $dir $1 | while read file; do
      if [[ ! $file == "." && ! $file == ".." ]]; then
        [[ -f $HOME/$dir/$file ]] && mv $HOME/$dir/$file $HOME/$dir/$file.bak

        cp $path/$dir/$file $HOME/$dir/$file
      fi
    done
  done
}

commons() {
  link_files & create_dirs

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
  python3 $PLUGGED/YouCompleteMe/install.py --ts-completer || $PLUGGED/YouCompleteMe/install.sh --ts-completer

  log "The following symbolic links were created:"
  cd $HOME && ls -la | grep "\->" | grep dotfiles | grep -v bak
}

rollback() {
  if [[ $OSTYPE == "linux-gnu" ]]; then
    for package in "${PACKAGES[@]}"; do
      sudo apt-get remove -y $package
    done

    # cleanup dependencies not loger needed
    sudo apt-get autoremove -y
  elif [[ $OSTYPE == "darwin18" || $OSTYPE == "darwin19" ]]; then
    for package in "${MACOS_PACKAGES[@]}"; do
      brew uninstall $package
    done
  else
    exit 1
  fi

  # remove all files and dirs created with this script
  for file in "${FILES[@]}"; do
    rm $HOME/$file
  done
  rm -rf $TMUX_TPM_DIR $PLUGGED $NVIM_CONFIG_DIR $HOME/.tmux

  log "cleanup done"
}

prompt_user() {
  log "What do you want to do? (install, rollback):"
  read ANSWER

  case $ANSWER in
    install) start_install ;;
    rollback) rollback ;;
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
