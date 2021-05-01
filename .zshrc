source $HOME/dotfiles/aliases
source $HOME/dotfiles/exports
source $HOME/dotfiles/utils

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

# git stuff in ps1
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%{%F{green}%B%}●%{%b%f%}'
zstyle ':vcs_info:*' unstagedstr '%{%F{red}%B%}●%{%b%f%}'
# zstyle ':vcs_info:*' formats '%{%F{cyan}%}%45<…<%R%<</%{%f%}%{%F{green}%}(%25>…>%b%<<)%{%f%}%{%F{cyan}%}%S%{%f%}%c%u'
zstyle ':vcs_info:git:*' formats '[%b%c%u] '
zstyle ':vcs_info:git+post-backend:*' hooks git-remote-staged

function +vi-git-remote-staged() {
  # Show "unstaged" when changes are not staged or not committed
  # Show "staged" when last committed is not pushed
  #
  # See original VCS_INFO_get_data_git for implementation details

  # Set "unstaged" when git reports either staged or unstaged changes
  if (( gitstaged || gitunstaged )) ; then
    gitunstaged=1
  fi

  # Set "staged" when current HEAD is not present in the remote branch
  if (( querystaged )) && \
     [[ "$(${vcs_comm[cmd]} rev-parse --is-inside-work-tree 2> /dev/null)" == 'true' ]] ; then
      # Default: off - these are potentially expensive on big repositories
      if ${vcs_comm[cmd]} rev-parse --quiet --verify HEAD &> /dev/null ; then
          gitstaged=1
          if ${vcs_comm[cmd]} status --branch --short | head -n1 | grep -v ahead > /dev/null ; then
            gitstaged=
          fi
      fi
  fi

  hook_com[staged]=$gitstaged
  hook_com[unstaged]=$gitunstaged
}

autoload -Uz vcs_info
precmd() { vcs_info }
setopt PROMPT_SUBST
PROMPT='${PWD/#$HOME/~} ${vcs_info_msg_0_} » '

# vim mode
bindkey -v

# MacOS stuff
if [[ $OSTYPE == darwin* ]]; then
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
  source $HOME/dotfiles/setup/debian/utils

  PS1="%B%2~%b $ "

  if [[ -z $TMUX ]]; then
    typeset -aU path
    path=($path /usr/sbin)
    path=($path /usr/local/go/bin)
  fi
fi

[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
