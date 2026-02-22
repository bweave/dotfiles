#  ___      _    __ _ _                _______ _  _
# |   \ ___| |_ / _(_) |___ ___  ___  |_  / __| || |
# | |) / _ \  _|  _| | / -_|_-< |___|  / /\__ \ __ |
# |___/\___/\__|_| |_|_\___/__/       /___|___/_||_|

# Edit command line in editor with Ctrl-X Ctrl-E
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Better sourcing of files
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

########################
# Brew
########################

if [[ -e "/opt/homebrew/bin/brew" ]]; then
  path_prepend /opt/homebrew/bin
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

path_prepend $HOME/.local/bin
path_prepend $HOME/bin
path_prepend $HOME/.rbenv/shims
path_prepend $HOME/.cargo/bin
path_prepend $HOME/.claude/local
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

include $HOME/.secrets
include $HOME/.fzf.zsh
include $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Starship prompt
eval "$(starship init zsh)"
function set_win_title(){
  echo -ne "\033]0; $(basename "$PWD") \007"
}
precmd_functions+=(set_win_title)

########################
# Zoxide - better cd
########################

eval "$(zoxide init zsh --cmd j)"

########################
# Rust
########################

. "$HOME/.cargo/env"

########################
# Ruby
########################

if [[ -d $HOME/.rbenv ]]; then
  eval "$(rbenv init -)"
fi
unsetopt nomatch # for rake tasks with args

########################
# Node via nvm
########################

include "/opt/homebrew/opt/nvm/nvm.sh"
include "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

########################
# PCO
########################

if [ -d "$HOME/pco-box" ]; then
  include ~/pco-box/env.sh
fi

########################
# Aliases
########################

# Pretty print $PATH in precedence order
alias path='echo $PATH | tr -s ":" "\n" | awk "{print NR \": \" \$0}"'

alias zshconfig="nvim ~/.zshrc"
alias nvim-min='NVIM_APPNAME=nvim_minimal nvim'

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
alias mux=tmuxinator

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

# Git Worktrees
alias gwl="git worktree list"
alias gwp="worktree prune" # util function to clean up worktree metadata in case you `rm -rf` a worktree folder

# Create a new git worktree and optionally a tmux session
# Usage: gwa <branch-name>
gwa() {
  local branch_name="$1"
  local repo_path=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ -z "$repo_path" ]]; then
    echo "Error: Not a git repository"
    return 1
  fi

  local repo_name=$(basename "$repo_path")
  local folder_suffix="${branch_name//\//-}" # ${var//pattern/replacement} replaces all `/` with `-`
  local worktree_path="../${repo_name}-${folder_suffix}"
  local absolute_path=$(cd "$(dirname "$repo_path")" && pwd)/${repo_name}-${folder_suffix}

  if git worktree add -b "$branch_name" "$worktree_path"; then
    local session_name="${repo_name}-${folder_suffix}"

    echo
    read -q "choice?Create tmux session '${session_name}'? (y/n) "
    echo
    if [[ "$choice" == "y" ]]; then
      if [[ -f "${absolute_path}/.envrc" ]]; then
        direnv allow "$absolute_path"
      fi
      tmux new-session -d -s "$session_name" -c "$absolute_path"
      if [[ -n "$TMUX" ]]; then
        tmux switch-client -t "$session_name"
      else
        tmux attach-session -t "$session_name"
      fi
    fi
  fi
}

# Remove a git worktree and optionally delete the branch
# Usage: gwr <branch-name>
gwr() {
  local branch_name="$1"
  local repo_path=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ -z "$repo_path" ]]; then
    echo "Error: Not a git repository"
    return 1
  fi

  local repo_name=$(basename "$repo_path")
  local folder_suffix="${branch_name//\//-}" # ${var//pattern/replacement} replaces all `/` with `-`
  local target_path="../${repo_name}-${folder_suffix}"
  if git worktree remove "$target_path"; then
    echo "Successfully removed worktree at $target_path"
    read -q "choice?Delete branch '$1' as well? (y/n) "
    echo
    if [[ "$choice" == "y" ]]; then
      git branch -d "$1"
    fi
  else
    echo "Error: Could not find or remove worktree at $target_path"
    return 1
  fi
}

# Ruby & Rails
alias be='bundle exec'
alias r="bundle exec rails"
alias rc="bin/rails console"
alias rs="bin/rails server"
alias rdebug='rdebug --host 127.0.0.1 --port 1234 -- bin/rails s'
alias yundle="yarn install && bundle install"
alias yundlegate="yarn install && bundle install && rails db:migrate"

# React Native
alias rn_clean="watchman watch-del-all && killall -9 node && rm -rf yarn.lock package-lock.json node_modules ios/Pods ios/Podfile.lock android/app/build && npm install && cd ios && pod update && cd .. && npm start -- --reset-cache"

# PCO stuff
alias super_tail="grc tail -f ~/Code/**/log/development.log"
alias super_tail_publishing="tail -f ~/Code/{api,church-center,publishing}/log/development.log /usr/local/var/log/nginx/{access,error}.log | bat --paging=never -l log"
alias cloudbox="pco cloud-box up --tmux-iterm -o SendEnv=GITHUB_TOKEN"
alias block_tests="rerun -bcx --no-notify -- bin/rails test test/models/page_test test/models/blocks_test test/models/blocks/* test/graphs/planning_center_api/pages_test test/graphs/church_center_api/pages_test test/commands/html_to_blocks_test"
alias dynamo="DYNAMO_ENDPOINT=http://localhost:8000 AWS_ACCESS_KEY_ID='developmentId' dynamodb-admin"

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

export EDITOR="nvim" # Make nvim the default editor
export VISUAL="nvim" # Make nvim the default editor
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!{.git,node_modules,vendor,bundle}/*"'
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
export PCO_APPS=accounts:api:calendar:check-ins:church-center:giving:groups:helpdesk:home:login:notifications:people:publishing:registrations:services:webhooks

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

fixssh() {
  eval $(tmux show-env -s |grep '^SSH_')
}

#################################
# Direnv - needs to be at the end
#################################
eval "$(direnv hook zsh)"

# bun completions
[ -s "/Users/brianweaver/.bun/_bun" ] && source "/Users/brianweaver/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# HSTR configuration - add this to ~/.zshrc
alias hh=hstr                    # hh to be alias for hstr
setopt histignorespace           # skip cmds w/ leading space from history
export HSTR_CONFIG=hicolor       # get more colors
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)
export HSTR_TIOCSTI=y

