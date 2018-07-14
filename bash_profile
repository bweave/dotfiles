# Load the shell dotfiles, and then some:
# for file in ~/.{path,bash_prompt,exports,aliases,functions,rax_creds,extra}; do
for file in ~/.{path,exports,aliases,functions,extra}; do
    [ -r "$file" ]; [ -f "$file" ]; source "$file"
done
unset file

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export RBENV_ROOT=$HOME/.rbenv
export MYSQL_PORT_3306_TCP_ADDR=127.0.0.1
export MYSQL_SLAVE_PORT_3306_TCP_ADDR=127.0.0.1
export MYSQL_SLAVE_PORT_3306_TCP_PORT=3307

#export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH="/Users/brianweaver/pco-box/bin:$PATH"
eval "$(/Users/brianweaver/Code/pco/bin/pco init -)"
eval "$(rbenv init -)"
