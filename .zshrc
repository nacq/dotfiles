# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=nvim

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
alias vim=nvim

if [[ $OSTYPE == linux* ]]; then
  alias openimage="feh -q --auto-zoom --scale-down --image-bg black"
  alias screenshot_multi="scrot ~/Desktop/screenshots/screenshot_%Y-%m-%d_%H%M%S.png"
  alias screenshot_current="scrot --focused ~/Desktop/screenshots/screenshot_%Y-%m-%d_%H%M%S.png"
  alias screenshot_select="scrot --select ~/Desktop/screenshots/screenshot_%Y-%m-%d_%H%M%S.png"

  source $HOME/dotfiles/arch/.utils
fi


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

[[ -n $SSH_CLIENT ]] && PS1="$(whoami)@$(hostname):%2~ »%b "

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export GOPATH="$HOME/projects/go"
