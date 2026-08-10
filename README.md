# Dotfiles

How to get set up:

## Before running `mac_setup`

- **1Password signed in.** Install the 1Password app (or sign in if it
  carried over via iCloud/Migration Assistant) and sign into the work
  account (`brian@pco.bz`). `mac_setup` uses the `op` CLI to populate
  `~/.secrets` from the vault. Not signed in yet? The script notices,
  prints the command to rerun, and continues with an empty file instead
  of failing outright - you can do this step after, just rerun that one
  command once you're signed in.

Everything else - Homebrew itself, Xcode Command Line Tools, GitHub CLI
auth, and a dedicated SSH key for GitHub (only generated if you don't
already have one) - is handled inline by the script. It'll prompt for
your password, click-through any GUI installers, and open a browser once
for GitHub auth as needed.

## Running `mac_setup`

1. Clone the repo to your `$HOME` directory (over HTTPS is fine here -
   `mac_setup` sets up SSH access itself before it needs it).
2. Run `./mac_setup` to:
  - Set up GitHub CLI auth and a dedicated SSH key
  - Install dependencies and apps via Homebrew
  - Symlink dotfiles via GNU Stow
  - Generate `~/.secrets` from 1Password
  - Install latest Neovim
  - Install Ruby via rbenv
  - Install Node via nvm along with some global packages

## After `mac_setup`

A few things are deliberately manual - `mac_setup` can't safely automate
them:

- If you rely on the `~/.claude` → `/var/empty` override (see `.zshrc`'s
  `claude-personal`/`claude-work` aliases) to block bare `claude`
  invocations, redo it by hand - a fresh `stow` run symlinks
  `~/.claude` to `dotfiles/.claude` instead.
