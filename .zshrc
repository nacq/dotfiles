# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

source $HOME/dotfiles/utils

alias vim=nvim

# MacOS stuff
if [[ $OSTYPE == darwin* ]]; then
  export ZSH=$HOME/.oh-my-zsh
  export GOPATH="$HOME/projects/go"

  alias python=python3
  alias pip=pip3
  alias ngrok=~/Applications/ngrok

  ZSH_THEME="minimal"

  # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
  # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
  # Example format: plugins=(rails git textmate ruby lighthouse)
  # Add wisely, as too many plugins slow down shell startup.
  plugins=(git)
  source $ZSH/oh-my-zsh.sh

  # .zshrc is evaluated for every zsh process
  # to avoid duplicated entries on the $PATH variable
  # only set these variables if tmux is not running
  if [[ -z $TMUX ]]; then
    typeset -aU path
    path=($path /usr/local/sbin)
    path=($path /Users/$(whoami)/Library/Python/3.9/bin)
  fi
fi

# Linux stuff
if [[ $OSTYPE == linux* ]]; then
  # history
  HISTSIZE=1000
  SAVEHIST=1000
  autoload -U history-search-end
  zle -N history-beginning-search-backward-end history-search-end
  zle -N history-beginning-search-forward-end history-search-end
  bindkey "^[[A" history-beginning-search-backward
  bindkey "^[[B" history-beginning-search-forward

  # autocomplete
  autoload -U compinit
  zstyle ':completion:*' menu select
  zmodload zsh/complist
  compinit
  # to include hidden files
  _comp_options+=(globdots)

  # vim mode
  bindkey -v
  # the default time is too long
  # this is used when changing vim modes
  export KEYTIMEOUT=1

  source $HOME/dotfiles/setup/debian/utils

  alias afk="i3lock -c 000000"
  alias chromium="chromium --force-device-scale-factor=1.25"
  alias uireload="xrdb -merge $HOME/.Xresources"
  alias xclip="xclip -selection c"
  alias scrot="scrot -s"
  alias open="xdg-open"

  PS1="%B%2~%b $ "

  if [[ -z $TMUX ]]; then
    typeset -aU path
    path=($path /usr/sbin)
    path=($path /usr/local/go/bin)
  fi
fi

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
