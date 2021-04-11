#!/usr/bin/bash

REPO_NAME="dotfiles"
dirs=(
  ".gnupg"
)
files=(
  ".bashrc"
  ".gitignore"
  ".tmux.conf"
  ".zshrc"
)
packages=(
  "chromium"
  "curl"
  "fzf"
  "git"
  "gnupg"
  "i3"
  "jq"
  "mesa-utils"
  "neovim"
  "silversearcher-ag"
  "suckless-tools"
  "tmux"
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

install_packages() {
  for package in "${packages[@]}"; do
    echo -e "Installing $package..."
    sudo apt install -y $package
  done
}

link_files() {
  for file in "${files[@]}"; do
    [[ -f $HOME/$file ]] && mv $HOME/$file $HOME/$file$(date +"%Y-%m-%d_%H:%M:%S").bkp 
    ln -sf $HOME/$REPO_NAME/$file $HOME/$file
  done
}

echo "Starting Debian based system setup..."

install_packages
link_files
# set zsh as the default shell 
# NOTE: this requires a logout to take effect
chsh -s $(which zsh)

echo "Debian based system setup finished. Restart the system now"
