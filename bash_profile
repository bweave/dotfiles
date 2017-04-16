# rbenv
eval "$(rbenv init -)"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you donÃ¢ÂÂt want to commit.

# for file in ~/.{path,bash_prompt,exports,aliases,functions,rax_creds,extra}; do
for file in ~/.{path,exports,aliases,functions,rax_creds,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file
