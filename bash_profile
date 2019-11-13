# Load the shell dotfiles, and then some:
# for file in ~/.{path,bash_prompt,exports,aliases,functions,rax_creds,extra}; do
for file in ~/.{path,exports,aliases,functions,extra,secrets}; do
    [ -r "$file" ]; [ -f "$file" ]; source "$file"
done
unset file

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export RBENV_ROOT=$HOME/.rbenv
export MYSQL_PORT_3306_TCP_ADDR=127.0.0.1
export MYSQL_SLAVE_PORT_3306_TCP_ADDR=127.0.0.1
export MYSQL_SLAVE_PORT_3306_TCP_PORT=3307
export PATH=/Users/brianweaver/pco-box/bin:/usr/local/bin:$PATH
eval "$(rbenv init -)"
