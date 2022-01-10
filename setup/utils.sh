#!/bin/bash

# Common functions used by any of the OSs while running the setup.

# $1 one of the dirs defined in $dirs in an absolute path format
# $2 the destination of the given directory
generate_nested_configs() {
  echo "working with $1"
  local repo_name="dotfiles"
  local dest=${1//"$HOME"\/"$repo_name"\/""}
  [[ -d $1 && ! -d "$dest" ]] && mkdir -p "$dest"
  # ls -X (dir first) does not work on macos
  [[ -d $1 ]] && ls -lA $1 | sort -r | awk 'NF==9 { print $9 }' | while read content; do
    resource_path=$1/$content
    # remove not needed parts of the abs path
    resource_to_create=${resource_path//"$HOME"\/"$repo_name"\/""}
    # TODO: handle file already exists
    [[ -f "$resource_path" ]] && ln -s "$resource_path" "$2"/"$resource_to_create"
    [[ -d "$resource_path" ]] && mkdir -p "$2"/"$resource_to_create" && generate_nested_configs "$1"/"$content" "$2"
  done
}

# $1 filename of the file to link
link_file() {
  [[ -f $HOME/$1 ]] && mv $HOME/$1 $HOME/$1_$(date +"%Y-%m-%d_%H:%M:%S").bkp
  ln -sf $HOME/$REPO_NAME/$1 $HOME/$1
}

# $1 package name to install
install_package() {
  echo "Installing $package"
  [[ $(uname) == "Darwin" ]] && brew install $1
  [[ $(uname) == "Linux" ]] && apt install -y $1
}

setup_tmux() {
  local tpm="$HOME/.tmux/plugins"
  export TMUX_PLUGIN_MANAGER_PATH=$tpm
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
  $tpm/tpm/bin/install_plugins
}

setup_vim() {
  [[ ! -d $HOME/.vim/plugged ]] && curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  nvim -c "PlugInstall" -c "qa!"
  nvim -c "CocInstall coc-tsserver coc-json coc-git" -c "qa!"
}
