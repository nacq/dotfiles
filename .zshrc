source $HOME/dotfiles/aliases
source $HOME/dotfiles/exports
source $HOME/dotfiles/functions
# to source stuff that are not sourced in the repo
source $HOME/dotfiles/source_extras 2> /dev/null

autoload -U colors && colors
setopt autocd

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# setopt inc_append_history
setopt share_history
setopt extended_history
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
# https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%{%F{#00875f}%B%}●%{%b%f%}'
zstyle ':vcs_info:*' unstagedstr '%{%F{#870000}%B%}●%{%b%f%}'
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

# vim mode
bindkey -v

# Linux stuff
if [[ $OSTYPE == linux* ]]; then
  PS1="%B%2~%b $ "

  if [[ -z $TMUX ]]; then
    typeset -aU path
    entries=(
      "/usr/sbin"
      "/usr/local/go/bin"
      "/opt/nvim-linux64/bin"
      "$HOME/.deno/bin"
      "$HOME/.cargo/bin"
      "$HOME/go/bin"
    )
    for entry in "${entries[@]}"; do
      path=($path $entry)
    done
  fi
fi

local ret_status="%(?..(°ʖ͡°%)╭∩╮ %s)"

PROMPT='${PWD/#$HOME/~} ${vcs_info_msg_0_}${ret_status}» '
