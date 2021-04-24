source $HOME/dotfiles/aliases
source $HOME/dotfiles/exports
source $HOME/dotfiles/utils

# MacOS stuff
if [[ $OSTYPE == darwin* ]]; then
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
  # autoload -U colors && colors
  setopt autocd

  # history
  HISTFILE=$HOME/.zsh_history
  HISTSIZE=1000
  SAVEHIST=1000
  autoload -U history-search-end
  # "smart history"
  zle -N history-beginning-search-backward-end history-search-end
  zle -N history-beginning-search-forward-end history-search-end
  bindkey "^[[A" history-beginning-search-backward-end
  bindkey "^[[B" history-beginning-search-forward-end

  # autocomplete
  autoload -U compinit
  zstyle ':completion:*' menu select
  zmodload zsh/complist
  compinit
  # to include hidden files
  _comp_options+=(globdots)

  # vim mode
  bindkey -v

  source $HOME/dotfiles/setup/debian/utils

  PS1="%B%2~%b $ "

  if [[ -z $TMUX ]]; then
    typeset -aU path
    path=($path /usr/sbin)
    path=($path /usr/local/go/bin)
  fi
fi

[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
