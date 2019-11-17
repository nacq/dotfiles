# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

ZSH_THEME="minimal"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias glog="\git log --color --all --date-order --decorate --dirstat=lines,cumulative --stat | sed 's/\([0-9] file[s]\? .*)$\)/\1\n_______\n-------/g' | \less -R"
alias vim=nvim

#
# vi mode
#
bindkey -v
# init in insert mode
autoload -U edit-command-line
export KEYTIMEOUT=1

# .zshrc is evaluated for every zsh process
# to avoid duplicated entries on the $PATH variable
# only set this variables if tmux is not running
if [[ -z $TMUX ]]; then
  # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
  export PATH="$PATH:$HOME/.rvm/bin"
  #export PATH=$(brew --prefix openvpn)/sbin:$PATH

  # Golang related vars
  export PATH="$PATH:/usr/local/Cellar/go/1.13.4/bin:$HOME/go/bin"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
