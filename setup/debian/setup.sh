#!/bin/bash

REPO_NAME="dotfiles"
LOG_FILE="$HOME/$REPO_NAME/setup/log/debian_setup"
# these directories should exist in this repo
dirs=(
  ".config"
  ".fonts"
  ".gnupg"
  ".urxvt"
)
debian_files=(
  ".xinitrc"
  ".xmodmaprc"
  ".xprofile"
  ".Xresources"
  "/etc/bluetooth/main.conf"
  "/etc/X11/xorg.conf.d/20-displaylink.conf"
  "/etc/X11/xorg.conf.d/40-libinput.conf"
  # "/etc/X11/xorg.conf.d/graphics-card.conf"
  # "/etc/X11/xorg.conf.d/monitors.conf"
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

setup_urxvt() {
  # at this point the dir .urxvt/ext/ should already be created by this script
  git clone https://github.com/majutsushi/urxvt-font-size $HOME/.urxvt/ext
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
  xorg_files_dir=$HOME/$REPO_NAME/setup/debian/xorg.conf.d

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
      for dir in "${dirs[@]}"; do
        generate_nested_configs $HOME/$REPO_NAME/$dir $HOME
      done
      ;;
    "setupapps")
      setup_xorg
      setup_urxvt
      setup_tmux
      setup_vim
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
      setup_urxvt
      setup_tmux
      setup_vim
      # set zsh as the default shell
      # NOTE: this requires a logout to take effect
      chsh -s $(which zsh)
      ;;
    *)
      echo -e "Usage: ./setup.sh [OPTION]
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
