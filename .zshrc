# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export GOPATH="$HOME/projects/go"

ZSH_THEME="minimal"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/dotfiles/utils

alias vim=nvim

if [[ $OSTYPE == darwin* ]]; then
  alias python=python3
  alias pip=pip3
  alias ngrok=~/Applications/ngrok

  # .zshrc is evaluated for every zsh process
  # to avoid duplicated entries on the $PATH variable
  # only set these variables if tmux is not running
  if [[ -z $TMUX ]]; then
    BASE_PATH="$PATH"

    # list of entries to add to the $PATH variable
    paths=(
      "/usr/local/sbin"
      "/Users/$(whoami)/Library/Python/3.9/bin"
    )

    for path_to_add in "${paths[@]}"; do
      BASE_PATH="$BASE_PATH:$path_to_add"
    done

    export PATH="$BASE_PATH"
  fi
fi

# show a slightly different PS1 when there is a ssh session
[[ -n $SSH_CLIENT ]] && PS1="$(whoami)@$(hostname):%2~ »%b "

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
