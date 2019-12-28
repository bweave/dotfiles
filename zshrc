source $HOME/.exports
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon background_jobs dir vcs rbenv)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="▶ "
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_DISABLE_RPROMPT=true
# ZSH_THEME="agnoster"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(extract fzf zsh-autosuggestions)

# for rake tasks with args
unsetopt nomatch

source $ZSH/oh-my-zsh.sh

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'

include () {
  [[ -f "$1" ]] && source "$1" || echo "$1 not found"
}

include $HOME/.secrets
include $HOME/.aliases
include $HOME/.functions
include $HOME/.path
include ~/.tmuxinator.zsh
eval "$(rbenv init -)"
[[ -f $HOME/Code/pco/bin/pco ]] && eval "$($HOME/Code/pco/bin/pco init -)"

# OS Specific bits
case "$OSTYPE" in
  darwin*)
    include /usr/local/etc/profile.d/authojump.sh
    ;;
  linux*)
    include /usr/share/autojump/autojump.sh
    ;;
esac
