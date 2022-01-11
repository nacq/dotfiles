#!/bin/bash

REPO_NAME="dotfiles"
LOG_FILE="$HOME/$REPO_NAME/log/debian_setup"
# these directories should exist in this repo
dirs=(
  ".config"
  ".fonts"
  ".gnupg"
  ".urxvt"
)
debian_files=(
  ".xinitrc"
  ".Xmodmap"
  ".Xresources"
  "/etc/bluetooth/main.conf"
  "/etc/X11/xorg.conf.d/20-displaylink.conf"
  "/etc/X11/xorg.conf.d/40-libinput.conf"
  "/etc/udev/rules.d/90-monitor-hotplug.rules"
  "/usr/local/bin/monitor-hotplug.sh"
  "/usr/share/applications/brave-browser.desktop"
)
files=(
  ".bashrc"
  ".gitconfig"
  ".tmux.conf"
  ".vimrc"
  ".zshrc"
)
packages=(
  "alsa-utils"
  "brave-browser"
  "curl"
  "feh"
  "fzf"
  "git"
  "gnupg"
  "i3"
  "jq"
  "libnotify-bin" # system notifications
  "mesa-utils"
  "network-manager"
  "notify-osd" # system notifications
  "openvpn"
  "pulseaudio"
  "pulseaudio-module-bluetooth"
  "rar"
  "rofi"
  "rxvt-unicode"
  "scrot"
  "silversearcher-ag"
  "suckless-tools"
  "tmux"
  "tree"
  "unp"
  "unzip"
  "vlc"
  "xclip"
  "xinit"
  "xorg"
  "xserver-xorg"
  "xutils"
  "zplug" # zsh plugin manager
  "zsh"
)

check_packages_installed() {
  for package in "${packages[@]}"; do
    apt list -a "$package" 2>/dev/null | grep -q installed || echo "$package is not installed"
  done
}

# $1 one of the dirs defined in $dirs in an absolute path format
# $2 the destination of the given directory
generate_nested_configs() {
  # listing sorted by extension (-X) this will make the dirs to get created first, omiting . and .. (-A)
  [[ -d $1 ]] && ls -aAX $1 | while read content; do
    resource_path=$1/$content
    # remove not needed parts of the abs path
    resource_to_create=${resource_path//"$HOME"\/"$REPO_NAME"\/""}
    # TODO: handle file already exists
    [[ -f "$resource_path" ]] && ln -sf "$resource_path" "$2"/"$resource_to_create"
    [[ -d "$resource_path" ]] && mkdir -p "$2"/"$resource_to_create" && generate_nested_configs "$1"/"$content" "$2"
  done
}

install_packages() {
  for package in "${packages[@]}"; do
    echo -e "Installing $package..."
    sudo apt install -y $package
  done
}

link_files() {
  for file in "${files[@]}"; do
    [[ -f $HOME/$file ]] && mv $HOME/$file $HOME/$file-$(date +"%Y-%m-%d_%H:%M:%S").bkp
    ln -sf $HOME/$REPO_NAME/$file $HOME/$file
  done
}

link_debian_files() {
  for file in "${debian_files[@]}"; do
    if [[ $file == "/"* ]]; then
      [[ -f $file ]] && sudo mv $file $file-$(date +"%Y-%m-%d_%H:%M:%S").bkp
      sudo ln -sfF $HOME/$REPO_NAME$file $file
    # TODO: revisit this. This is still pointing to /setup/debian
    else
      [[ -f $HOME/$file ]] && mv $HOME/$file $HOME/$file-$(date +"%Y-%m-%d_%H:%M:%S").bkp
      ln -sf $HOME/$REPO_NAME/setup/debian/$file $HOME/$file
    fi
  done
}

log() {
  echo -e "\n$(date +"%Y-%m-%d_%H:%M:%S") - $1" >> "$LOG_FILE"
}

setup_tmux() {
  tpm="$HOME/.tmux/plugins"
  export TMUX_PLUGIN_MANAGER_PATH=$tpm
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
  $tpm/tpm/bin/install_plugins
  unset TMUX_PLUGIN_MANAGER_PATH
}

# $1 is app name st | dwm | dmenu
# $2 git repo url
setup_suckless_app() {
  diff="$HOME/dotfiles/diffs/$1.diff"

  [[ ! -d "$HOME/$1" ]] && git clone $2 $HOME/$1

  cd $HOME/$1
  rm -f config.h

  [[ -f "$diff" ]] && git apply "$diff"

  sudo make clean install
}

# spoon comes from a different repo is not hosted in suckless
setup_spoon() {
  echo "TODO"
  # diff="$HOME/dotfiles/setup/suckless-diffs/spoon-config.diff"

  # [[ ! -d "$HOME/spoon" ]] && git clone git://git.codemadness.org/spoon $HOME/spoon

  # cd $HOME/spoon

  # [[ -f "$diff" ]] && git apply "$diff"

  # sudo apt install libxkbfile-dev mpd libmpdclient-dev

  # ./configure && sudo make clean install
}

setup_vim() {
  sudo curl -Lo /opt/nvim-linux64.tar.gz \
    https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz &&
    cd /opt &&
    sudo tar xvf nvim-linux64.tar.gz &&
    sudo rm nvim-linux64.tar.gz
  [[ ! -d $HOME/.vim/plugged ]] && curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  nvim -c "PlugInstall" -c "qa!"
  nvim -c "CocInstall coc-tsserver" -c "qa!"
  nvim -c "CocInstall coc-json" -c "qa!"
}

setup_xorg() {
  x_dir=/etc/X11
  xorg_conf_dir="$x_dir"/xorg.conf.d
  xorg_files_dir=$HOME/$REPO_NAME/xorg.conf.d

  [[ ! -d "$x_dir" ]] && sudo mkdir -p "$xorg_conf_dir"
  [[ ! -d "$xorg_conf_dir" ]] && sudo mkdir "$xorg_conf_dir"

  ls "$xorg_files_dir" | while read content; do
    sudo ln -sf "$xorg_files_dir"/"$content" "$xorg_conf_dir"/"$content"
  done
}

main() {
  [[ ! -f "$LOG_FILE" ]] && touch "$LOG_FILE"
  log $1

  case $1 in
    "check-packages-installed")
      check_packages_installed
      ;;
    "suckless-diffs")
      generate_suckless_diffs
      ;;
    "dwm")
      setup_suckless_app dwm "git://git.suckless.org/dwm"
      sudo update-alternatives --install /usr/bin/x-window-manager x-window-manager $(which dwm) 50
      ;;
    # TODO: remove
    "dwmstatus")
      setup_suckless_app dwmstatus "git://git.suckless.org/dwmstatus"
      ;;
    "st")
      setup_suckless_app st "git://git.suckless.org/st"
      # make it the default term
      sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which st) 50
      ;;
    "packages")
      install_packages
      ;;
    "link")
      link_files
      link_debian_files
      for dir in "${dirs[@]}"; do
        generate_nested_configs $HOME/$REPO_NAME/$dir $HOME
      done
      ;;
    "setupapps")
      # TODO: call this script with the proper arg instead of the function directly
      setup_xorg
      setup_tmux
      setup_vim
      setup_suckless_app dwm
      setup_suckless_app dwmstatus
      setup_suckless_app st
      # set zsh as the default shell
      # NOTE: this requires a logout to take effect
      chsh -s $(which zsh)
      ;;
    "all")
      install_packages
      link_files
      link_debian_files
      for dir in "${dirs[@]}"; do
        generate_nested_configs $HOME/$REPO_NAME/$dir $HOME
      done
      setup_xorg
      setup_tmux
      setup_vim
      setup_suckless_app dwm
      setup_suckless_app dwmstatus
      setup_suckless_app st
      # set zsh as the default shell
      # NOTE: this requires a logout to take effect
      chsh -s $(which zsh)
      ;;
    *)
      echo -e "Usage: ./install.sh [OPTION]
      - 'check-packages-installed', to check if all the listed packages are installed.
      - 'suckless-diffs', to generate suckless diffs,
      - 'dwm', to setup dwm,
      - 'dwmstatus', to setup dwmstatus,
      - 'st', to setup st,
      - 'packages', to install packages.
      - 'link', to generate symbolic links.
      - 'setupapps', to setup the different apps.
      - 'all', to execute everything." && \
        exit 1
      ;;
  esac
}

main $1 | tee -a "$LOG_FILE"
