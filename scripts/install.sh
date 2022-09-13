#!/bin/bash

REPO_NAME="dotfiles"
LOG_FILE="$HOME/$REPO_NAME/log/debian_setup"
# where suckless apps source code lives
SUCKLESS_DIR="$HOME/suckless"

packages=(
  "alsa-utils"
  "apt-file"
  "at" # schedule commands
  "build-essential"
  "curl"
  "feh"
  "fzf"
  "git"
  "gnupg"
  "jq"
  "libnotify-bin" # system notifications
  "make"
  "mesa-utils"
  "network-manager"
  "notify-osd" # system notifications
  "openvpn"
  "pulseaudio"
  "pulseaudio-module-bluetooth"
  "rar"
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
  sudo apt update
  for package in "${packages[@]}"; do
    echo -e "Installing $package..."
    sudo apt install -y $package
  done
}

link_files() {
  local files=(
    ".Xmodmap"
    ".Xresources"
    ".gitconfig"
    ".tmux.conf"
    ".vimrc"
    ".xinitrc"
    ".zshrc"
  )
  for file in "${files[@]}"; do
    [[ -f $HOME/$file ]] && mv $HOME/$file $HOME/$file-$(date +"%Y-%m-%d_%H:%M:%S").bkp
    ln -sf $HOME/$REPO_NAME/$file $HOME/$file
  done
}

link_debian_files() {
  local debian_files=(
    "/etc/bluetooth/main.conf"
    "/etc/X11/xorg.conf.d/40-libinput.conf"
    "/etc/systemd/network/10-rename-wlp58s0.link"
    "/etc/udev/rules.d/10-monitor-hotplug.rules"
    "/usr/share/applications/brave-browser.desktop"
  )
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
  [[ ! -d "$SUCKLESS_DIR" ]] && mkdir "$SUCKLESS_DIR"

  diff="$HOME/dotfiles/diffs/$1.diff"

  [[ ! -d "$SUCKLESS_DIR/$1" ]] && git clone $2 $SUCKLESS_DIR/$1

  cd $SUCKLESS_DIR/$1
  [[ -f config.h ]] && rm -f config.h

  [[ -f "$diff" ]] && git apply "$diff"

  sudo make clean install
}

setup_dwm() {
  sudo apt install -y libxft-dev libxinerama-dev
  setup_suckless_app dwm "git://git.suckless.org/dwm" && \
    sudo update-alternatives --install /usr/bin/x-window-manager x-window-manager $(which dwm) 50
}

setup_nvim() {
  # there is an old version still in apt
  # sudo apt install -y neovim
  sudo curl -Lo /opt/nvim-linux64.tar.gz \
    https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz &&
    cd /opt &&
    sudo tar xvf nvim-linux64.tar.gz &&
    sudo rm nvim-linux64.tar.gz
  # nvim plugin manager
  [[ ! -d $HOME/.vim/plugged ]] && \
    curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  nvim -c "PlugInstall" -c "qa!"
}

setup_st() {
  setup_suckless_app st "git://git.suckless.org/st"
  # make it the default term
  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which st) 50
}

setup_slock() {
  sudo apt install -y libxrandr-dev && \
    setup_suckless_app slock "git://git.suckless.org/slock"
}

setup_dwmstatus() {
  setup_suckless_app dwmstatus "git://git.suckless.org/dwmstatus"
}

setup_sxiv() {
  sudo apt install -y libimlib2-dev libexif-dev && \
    setup_suckless_app sxiv "https://github.com/nicolasacquaviva/sxiv"
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
    "packages")
      install_packages
      ;;
    "link")
      link_files
      link_debian_files
      ;;
    "setupapps")
      setup_dwm
      setup_dwmstatus
      setup_nvim
      setup_slock
      setup_slstatus
      setup_st
      setup_sxiv
      setup_tmux
      setup_xorg
      sudo apt install -y firefox-esr
      # set zsh as the default shell
      # NOTE: this requires a logout to take effect
      chsh -s $(which zsh)
      ;;
    "all")
      $HOME/dotfiles/scripts/install.sh packages
      $HOME/dotfiles/scripts/install.sh link
      # these directories should exist in this repo
      local dirs=(
        ".config"
        ".gnupg"
      )
      for dir in "${dirs[@]}"; do
        generate_nested_configs $HOME/$REPO_NAME/$dir $HOME
      done
      $HOME/dotfiles/scripts/install.sh setupapps
      ;;
    *)
      echo -e "Usage: ./install.sh [OPTION]
      - 'check-packages-installed', to check if all the listed packages are installed.
      - 'packages', to install packages.
      - 'link', to generate symbolic links.
      - 'setupapps', to setup the different apps.
      - 'all', to execute everything." && \
        exit 1
      ;;
  esac
}

main $1 | tee -a "$LOG_FILE"
