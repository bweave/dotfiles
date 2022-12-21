#  ___      _    __ _ _                _______ _  _
# |   \ ___| |_ / _(_) |___ ___  ___  |_  / __| || |
# | |) / _ \  _|  _| | / -_|_-< |___|  / /\__ \ __ |
# |___/\___/\__|_| |_|_\___/__/       /___|___/_||_|
#
# 1. Path
# 2. ZSH
# 3. PCO
# 4. Ruby
# 5. Nvm
# 6. Aliases
# 7. Exports
# 8. Functions

include () {
  [[ -f "$1" ]] && \. "$1" || echo "$1 not found"
}

########################
# Path
########################

# In zsh $PATH is tied (see typeset -T) to the $path array.
# You can force that array to have unique values with:
typeset -U path

# if the dir exists and it's not already in PATH, prepend it
path_prepend() {
  path=($1 "$path[@]")
}

path_prepend $HOME/.local/bin
path_prepend $HOME/bin
path_prepend $HOME/.rbenv/shims
path_prepend $HOME/.cargo/bin
if command -v go &> /dev/null; then
  path_prepend $(go env GOPATH)/bin
fi
if [ -d $HOME/Code/pco ]; then
  path_prepend $HOME/Code/pco/bin
fi

# ensure PATH only has unique values with -U
export -U PATH

########################
# ZSH
########################

# Starship prompt
eval "$(starship init zsh)"
function set_win_title(){
  echo -ne "\033]0; $(basename "$PWD") \007"
}
precmd_functions+=(set_win_title)

include $HOME/.fzf.zsh
case "$OSTYPE" in
  darwin*)
    include $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    include $HOME/.secrets
    ;;
  linux*)
    include /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ;;
esac

# Completions.
case "$OSTYPE" in
  darwin*)
    include $(brew --prefix)/etc/profile.d/bash_completion.sh
    include $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
    ;;
  linux*)
    include /etc/profile.d/bash_completion.sh
    ;;
esac
autoload -Uz compinit && compinit
# Case insensitive.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

case "$OSTYPE" in
  darwin*)
    include "$(brew --prefix)/etc/profile.d/autojump.sh"
    ;;
  linux*)
    include "/usr/share/autojump/autojump.sh"
    ;;
esac

########################
# Base16 Kitty Theme
########################

if [ ! -z $KITTY_PID ]; then
  if [ -d "$HOME/src/base16-kitty" ]; then
    eval "kitty @ set-colors -a -c $HOME/src/base16-kitty/colors/$(cat $HOME/.base16_theme).conf"
  fi
fi

########################
# Ruby
########################

if type rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi
unsetopt nomatch # for rake tasks with args

########################
# PCO
########################

if [ -d "$HOME/pco-box" ]; then
  include ~/pco-box/env.sh
fi

########################
# Nvm
########################

case "$OSTYPE" in
  darwin*)
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    ;;
esac

########################
# Aliases
########################

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

alias kitty_theme="cd $HOME/src/base16-kitty && fzf --preview 'head -n 100 {} && kitty @ set-colors -c {}'; cd -"

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
# eval "$(hub alias -s)" # Use `hub` as our git wrapper
alias undopush="git push -f origin HEAD^:master"
alias gs="git status -sb"
alias gco="git checkout"
alias gcb="git branch | fzf | xargs git checkout"
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

# React Native
alias rn_clean="watchman watch-del-all && killall -9 node && rm -rf yarn.lock package-lock.json node_modules ios/Pods ios/Podfile.lock android/app/build && npm install && cd ios && pod update && cd .. && npm start -- --reset-cache"

# PCO stuff
alias super_tail="grc tail -f ~/Code/**/log/development.log"
alias super_tail_publishing="tail -f ~/Code/{api,church-center,publishing}/log/development.log /usr/local/var/log/nginx/{access,error}.log | bat --paging=never -l log"
alias cloudbox="pco cloud-box up --tmux-iterm -o SendEnv=GITHUB_TOKEN"
alias block_tests="rerun -bcx --no-notify -- bin/rails test test/models/page_test test/models/blocks_test test/models/blocks/* test/graphs/planning_center_api/pages_test test/graphs/church_center_api/pages_test test/commands/html_to_blocks_test"

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
export DISABLE_AUTO_TITLE='true'
export EDITOR="nvim" # Make vim the default editor
export VISUAL="nvim" # Make vim the default editor
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export HISTCONTROL=ignoredups
export HISTFILESIZE=$HISTSIZE
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help" # Make some commands not show up in history
export HISTSIZE=32768 # Larger bash history (allow 32³ entries; default is 500)
export HOMEBREW_NO_AUTO_UPDATE=1
export LANG="en_US" # Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LESS_TERMCAP_md="$ORANGE" # Highlight section titles in manual pages
export MANPAGER="less -X" # Don’t clear the screen after quitting a manual page
export PRERENDER_SERVICE_URL=http://localhost:3000
export SSH_KEY_PATH="~/.ssh/rsa_id" # ssh
export NVM_DIR="$HOME/.nvm"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#d75f87'

case "$OSTYPE" in
  darwin*)
    export CLICOLOR=1 # Set CLICOLOR if you want Ansi Colors in iTerm2
    export TERM="xterm-256color" # Set colors to match iTerm2 Terminal Colors
    export PCO_CLOUDBOX_AFTER_PROVISION_SCRIPT_PATH=~/dotfiles/cloudbox_setup
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

function start_all_pco_apps() {
  box prevent-idle

  Apps=(
    accounts
    api
    avatars
    check-ins
    church-center
    giving groups
    helpdesk
    login
    notifications
    people
    publishing
    registrations
    resources
    services
    webhooks
  )

  for app in ${Apps[*]}
  do
    { curl -v $app.pco.test &>/dev/null }
  done
}

fixssh() {
  eval $(tmux show-env -s |grep '^SSH_')
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
export BASE16_SHELL_HOOKS="$HOME/.config/base16-shell-hooks/"
[ -n "$PS1" ] && \
	[ -s "$BASE16_SHELL/profile_helper.sh" ] && \
	source "$BASE16_SHELL/profile_helper.sh"

function zvm_config() {
  ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
  ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
  ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
}
function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
