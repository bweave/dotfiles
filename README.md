# Dotfiles

How to get set up:

## Before running `mac_setup`

- **SSH key on GitHub.** `mac_setup` clones this repo over SSH
  (`git@github.com:bweave/dotfiles.git`). Generate a key
  (`ssh-keygen -t ed25519`) and add it to GitHub before running the
  script, or the clone step fails immediately.
- **1Password signed in.** Install the 1Password app (or sign in if it
  carried over via iCloud/Migration Assistant) and sign into the work
  account (`brian@pco.bz`). `mac_setup` uses the `op` CLI to populate
  `~/.secrets` from the vault. Not signed in yet? The script notices,
  prints the command to rerun, and continues with an empty file instead
  of failing outright - you can do this step after, just rerun that one
  command once you're signed in.

Everything else (Homebrew itself, Xcode Command Line Tools) is handled
inline by the script - it'll prompt for your password and click-through
any GUI installers as needed.

## Running `mac_setup`

1. Clone the repo to your `$HOME` directory.
2. Run `./mac_setup` to:
  - Install dependencies and apps via Homebrew
  - Symlink dotfiles via GNU Stow
  - Generate `~/.secrets` from 1Password
  - Install latest Neovim
  - Install Ruby via rbenv
  - Install Node via nvm along with some global packages

## After `mac_setup`

A few things are deliberately manual - `mac_setup` can't safely automate
them:

- `gh auth login` - GitHub CLI auth for PRs, issues, etc.
- If you rely on the `~/.claude` → `/var/empty` override (see `.zshrc`'s
  `claude-personal`/`claude-work` aliases) to block bare `claude`
  invocations, redo it by hand - a fresh `stow` run symlinks
  `~/.claude` to `dotfiles/.claude` instead.
