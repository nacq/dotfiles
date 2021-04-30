#!/bin/sh

REPO_NAME="dotfiles"

source $HOME/$REPO_NAME/setup/utils.sh

files=(
  ".gitconfig"
  ".tmux.conf"
  ".vimrc"
  ".zshrc"
)
packages=(
  "ag"
  "fzf"
  "neovim"
  "tmux"
)

dirs=(
  ".config"
  ".gnupg"
)

main() {
  echo "Starting Macos based system setup..."
  # install brew OS package manager
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  for package in "${packages[@]}"; do
    install_package $package
  done
  for file in "${files[@]}"; do
    link_file $file
  done
  for dir in "${dirs[@]}"; do
    generate_nested_configs $HOME/$REPO_NAME/$dir $HOME
  done
  setup_tmux
  setup_vim
  echo "Macos based system setup finished"
}

main
