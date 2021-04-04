#  ___      _    __ _ _                _______ _  _
# |   \ ___| |_ / _(_) |___ ___  ___  |_  / __| || |
# | |) / _ \  _|  _| | / -_|_-< |___|  / /\__ \ __ |
# |___/\___/\__|_| |_|_\___/__/       /___|___/_||_|
#
# 1. ZSH
# 2. Aliases
# 3. Exports
# 4. Functions

########################
# ZSH
########################

export ZSH=~/.oh-my-zsh # Path to your oh-my-zsh installation.
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'

plugins=(extract fzf zsh-autosuggestions)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

include () {
  [[ -f "$1" ]] && source "$1" || echo "$1 not found"
}

include $ZSH/oh-my-zsh.sh
include $HOME/.p10k.zsh
include $HOME/.fzf.zsh
include $HOME/.secrets
eval "$(rbenv init -)"
[[ -f $HOME/Code/pco/bin/pco ]] && eval "$($HOME/Code/pco/bin/pco init -)"
unsetopt nomatch # for rake tasks with args

case "$OSTYPE" in
  darwin*)
    include "/usr/local/etc/profile.d/autojump.sh"
    ;;
  linux*)
    include "/usr/share/autojump/autojump.sh"
    ;;
esac

########################
# Aliases
########################

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

alias sshkey="cat ~/.ssh/id_rsa.pub | pbcopy ; echo 'Copied to Clipboard.'"
alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias l="ls -lF -G" # List all files colorized in long format
alias ll="ls -lF -G"
alias la="ls -laF -G" # List all files colorized in long format, including dot files
alias lsd='ls -lF -G | grep "^d"' # List only directories
alias sudo='sudo '
alias dc=docker-compose
alias c=clear
alias grep="grep --color=auto"

# Git
eval "$(hub alias -s)" # Use `hub` as our git wrapper
alias undopush="git push -f origin HEAD^:master"
alias gs="git status -sb"
alias gco="git checkout"
alias gc="git commit -m "
alias gpub='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias gunpub='git push origin :$(git rev-parse --abbrev-ref HEAD)'
alias gp="git pull"
alias gd="git diff"
alias gb="git branch"
alias gba="git branch -a"
alias gdel="git branch -d"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gwip="git add -A && git commit --no-verify -m 'WIP'"
alias gunwip="git log -n 1 | grep -q -c 'WIP' ; git reset HEAD~1"
alias nah="echo '(╯°□°)╯︵ ┻━┻' && git reset --hard;git clean -df;"
alias commit_count='git rev-list --count HEAD ^master'

# Ruby & Rails
alias be='bundle exec'
alias r="bundle exec rails"
alias rc="bin/rails console"
alias rs="bin/rails server"
alias rdebug='rdebug --host 127.0.0.1 --port 1234 -- bin/rails s'
alias rdebug='rdebug-ide --host 127.0.0.1 --port 1234 -- bin/rails s'
alias yundle="yarn install && bundle install"

# PCO stuff
alias super_tail="grc tail -f ~/Code/**/log/development.log"
alias super_tail_publishing="tail -f ~/Code/{api,church-center,publishing}/log/development.log /usr/local/var/log/nginx/{access,error}.log | bat --paging=never -l log"

# Exercism.io
alias exrb='nvim -O *.rb term://"rerun -x -b --dir . --pattern \"*.rb\" -- ruby -r minitest/pride *_test.rb"'
alias expy='nvim -O *.py term://"rerun -x -b --dir . --pattern \"*.py\" -- pytest *_test.py"'
alias exbash='nvim -O *.sh term://"rerun -x --dir . --pattern \"*.sh\" -- bats *_test.sh"'
alias excr='nvim -O {src,spec}/*.cr term://"rerun -x --dir src,spec --pattern *.cr -- crystal spec"'

case "$OSTYPE" in
  darwin*)
    alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
    alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
    alias resetav="sudo killall VDCAssistant"
    alias python=/usr/local/bin/python3
    alias pip=/usr/local/bin/pip3
    ;;
  linux*)
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
    ;;
esac

########################
# Exports
########################

export ANSIBLE_ROLES_PATH=~/.ansible/roles
export AWS_CLOUDBOX_EC2_INSTANCE_ID="i-0022c06a166ea7f0e"
export DISABLE_AUTO_TITLE='true'
export EDITOR="nvim" # Make vim the default editor
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export HISTCONTROL=ignoredups
export HISTFILESIZE=$HISTSIZE
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help" # Make some commands not show up in history
export HISTSIZE=32768 # Larger bash history (allow 32³ entries; default is 500)
export LANG="en_US" # Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LESS_TERMCAP_md="$ORANGE" # Highlight section titles in manual pages
export MANPAGER="less -X" # Don’t clear the screen after quitting a manual page
export MYSQL_PORT_3306_TCP_ADDR=127.0.0.1
export MYSQL_READER_PORT_3306_TCP_ADDR=127.0.0.1
export MYSQL_READER_PORT_3306_TCP_PORT=3307
export PCO_BOX_LEAVE_DOCKER_RUNNING=true
export PRERENDER_SERVICE_URL=http://localhost:3000
export RAILS_ENV=development
export RBENV_ROOT=$HOME/.rbenv
export REACT_APP_TRELLO_API_KEY=516f350ffb583506c2e181417968f310
export SSH_KEY_PATH="~/.ssh/rsa_id" # ssh

case "$OSTYPE" in
  darwin*)
    export CLICOLOR=1 # Set CLICOLOR if you want Ansi Colors in iTerm2
    export TERM="xterm-256color" # Set colors to match iTerm2 Terminal Colors
    ;;
  linux*)
    export TERM="screen-256color"
    ;;
esac

########################
# Functions
########################

function mkd {
    mkdir -p "$@" && cd "$@";
}

# extract any type of compressed file
function extract {
  echo Extracting $1 ...
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1  ;;
      *.tar.xz)    tar xJf $1  ;;
      *.tar.gz)    tar xzf $1  ;;
      *.bz2)       bunzip2 $1  ;;
      *.rar)       rar x $1    ;;
      *.gz)        gunzip $1   ;;
      *.tar)       tar xf $1   ;;
      *.tbz2)      tar xjf $1  ;;
      *.tgz)       tar xzf $1  ;;
      *.zip)       unzip $1   ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1  ;;
      *)        echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function gbranches() {
  git branch --sort=committerdate |
    tail -r |
    sed 's/^..//' |
    xargs -I{} -n 1 git log -1 --color --format='%C(green){}%Creset|%ai|%C(dim)%hi%Creset|%C(yellow)%s%Creset' {} |
    column -t -s "|"
  }

function fgb() {
  if [[ "$ZSH_SUBSHELL" == "0" ]]; then
    git checkout $(fgb)
  else
    gbranches |
      fzf --height 40% --ansi |
      awk '{print $1}' |
      sed 's#^remotes/[^/]*/##'
  fi
}

case "$OSTYPE" in
  darwin*)
    update_pis() {
      for pi in rpi2 rpi3 rpi4 rpi400; do
        echo "\n⚙️   Updating $pi...\n"
        ssh -t $pi "sudo apt-get update && sudo apt-get upgrade -y"
      done
    }
  ;;
linux*)
  # ...
  ;;
esac
