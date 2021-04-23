#!/usr/bin/bash

REPO_NAME="dotfiles"
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
  "chromium"
  "curl"
  "fzf"
  "git"
  "gnupg"
  "i3"
  "jq"
  "mesa-utils"
  "neovim"
  "network-manager"
  "openvpn"
  "pulseaudio"
  "rar"
  "rxvt-unicode"
  "scrot"
  "silversearcher-ag"
  "suckless-tools"
  "tmux"
  "vlc"
  "unzip"
  "unp"
  "xinit"
  "xorg"
  "xserver-xorg"
  "xutils"
  "zsh"
  "zplug" # zsh plugin manager
)

check_packages_installed() {
  for package in "${packages[@]}"; do
    if [[ $package == "silversearcher-ag" ]]; then
      which ag > /dev/null || echo "$package is not installed"
    elif [[ $package == "neovim" ]]; then
      which nvim > /dev/null || echo "$package is not installed"
    else
      which $package > /dev/null || echo "$package is not installed"
    fi
  done
}

# $1 one of the dirs defined in $dirs in an absolute path format
# $2 the destination of the given directory
generate_nested_configs() {
  echo "working with $1"
  # listing sorted by extension (-X) this will make the dirs to get created first, omiting . and .. (-A)
  [[ -d $1 ]] && ls -aAX $1 | while read content; do
    resource_path=$1/$content
    # remove not needed parts of the abs path
    resource_to_create=${resource_path//"$HOME"\/"$REPO_NAME"\/""}
    # TODO: handle file already exists
    [[ -f "$resource_path" ]] && ln -s "$resource_path" "$2"/"$resource_to_create"
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
    [[ -f $HOME/$file ]] && mv $HOME/$file $HOME/$file_$(date +"%Y-%m-%d_%H:%M:%S").bkp
    ln -sf $HOME/$REPO_NAME/$file $HOME/$file
  done
}

link_debian_files() {
  for file in "${debian_files[@]}"; do
    [[ -f $HOME/$file ]] && mv $HOME/$file $HOME/$file_$(date +"%Y-%m-%d_%H:%M:%S").bkp
    ln -sf $HOME/$REPO_NAME/setup/debian/$file $HOME/$file
  done
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
  [[ ! -d $HOME/.vim/plugged ]] && curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  nvim -c "PlugInstall" -c "qa!"
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
  echo "Starting Debian based system setup..."

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

  echo "Debian based system setup finished. Restart the system now"
}

main
