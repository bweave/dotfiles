source $HOME/.exports
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="powerlevel9k/powerlevel9k"
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

source $HOME/.secrets
source $HOME/.aliases
source $HOME/.functions
source $HOME/.path
source /usr/local/etc/profile.d/autojump.sh
source ~/.tmuxinator.zsh
eval "$(rbenv init -)"
eval "$($HOME/Code/pco/bin/pco init -)"
