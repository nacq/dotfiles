#!/usr/bin/env bash
#
# Style guide: https://google.github.io/styleguide/shell.xml

OHMYSZH_DIR=$HOME/.oh-my-zsh
TMUX_TPM_DIR=$HOME/.tmux/plugins/tpm/
PLUGGED=$HOME/.vim/plugged
NVIM_CONFIG_DIR=$HOME/.config/nvim

path=$(pwd)

ARCH_FILES=(
  ".xinitrc"
  ".xprofile"
  ".Xmodmap"
)
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
ARCH_PACKAGES=(
  "community/ttf-ubuntu-font-family"
  "feh"
  "openssh"
  "openvpn"
  "scrot"
  "the_silver_searcher"
  "transmission-cli"
  "unzip"
  "xcompmgr"
  "xcopy"
)
MACOS_PACKAGES=(
  "neovim"
  "tmux"
  "fzf"
  "the_silver_searcher"
)

# $1 string to log
# $2 log "level" "info | error | success"
log() {
  case $2 in
    error) LEVEL=91m ;;
    info) LEVEL=94m ;;
    success) LEVEL=92m ;;
    **) LEVEL=94m ;;
  esac

  echo -e "\033[$LEVEL >>>\033[0m" $1
}

osx_install() {
  for package in "${MACOS_PACKAGES[@]}"; do
    [[ $package == "the_silver_searcher" ]] && package="ag"
    [[ -x "$(command which $package)" ]] || brew install $package && log "$package installed"
  done

  commons
}

# this will install $PACKAGES using `pacman` package manager,
# apply patches and build some utils
# and create the needed symbolic links
arch_install() {
  if [[ "$EUID" -ne 0 ]]; then
    log "Please run as root" "error"
    exit 1
  fi

  # install packages
  for package in "${ARCH_PACKAGES[@]}"; do
    pacman -Sy $package
  done

  # this sucks
  HOME="/home/nico"

  # apply patches
  for file in $HOME/dotfiles/arch/*; do EXTENSION=${file#*.}
    if [[ $EXTENSION == 'diff' ]]; then
      APPLICATION=`echo $file | awk -F '/' '{ print $NF }' | awk -F '-' '{ print $1 }'`
      echo $HOME/$file

      # check if app is installed before applying the patch
      if [[ -x `which $APPLICATION` ]]; then
        cd /usr/src/$APPLICATION
        patch -b config.h $file && make clean install && log "$APPLICATION patched and built" "success"
      fi
    fi
  done

  # create symlinks
  for file in "${ARCH_FILES[@]}"; do
    if [[ -f $HOME/$file ]]; then
      mv $HOME/$file $HOME/$file_$(timestamp).bak
    fi

    ln -sf $HOME/dotfiles/arch/$file $HOME/$file

    [[ $? == 0 ]] && log "Symlink $HOME/dotfiles/arch/$file to $HOME/$file created" "info"
  done

  # commons

  exit 0
}

timestamp() {
  date +%Y%m%d_%H%M%S
}

linux_install() {
  # root check
  # if [[ "$EUID" -ne 0 ]]; then
    # echo " >>> Please run as root"
    # exit 1
  # fi

  OS=`cat /etc/os-release | grep ^ID | awk -F '=' '{ print $2 }'`

  [[ $OS == 'arch' ]] && arch_install

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
  log "What do you want to do? (install, rollback, symlinks):"
  read ANSWER

  case $ANSWER in
    install) start_install ;;
    rollback) rollback ;;
    symlinks) link_files ;;
    **) prompt_user ;;
  esac
}

start_install() {
  case $OSTYPE in
    darwin*) osx_install ;;
    linux*) linux_install ;;
    **) log "Unsupported OS ${OSTYPE}" && exit 1 ;;
  esac

  log "Done! Restart the terminal" && exit 0
}

main() {
  prompt_user
}

main
