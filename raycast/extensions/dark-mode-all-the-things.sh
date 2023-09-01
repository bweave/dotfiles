#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Dark Mode
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ⚡
# @raycast.packageName Dark Mode ALL THE THINGS

# Documentation:
# @raycast.description Toggles macOS Dark Mode and sets Neovim colorscheme
# @raycast.author bweave
# @raycast.authorURL https://raycast.com/bweave

# toggle dark mode
osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'

# Use nvr to set all the neovim instances' colorschemes to match the current dark mode.
# To install: brew install neovim-remote
if command -v nvr &> /dev/null
then
  for servername in $(nvr --serverlist); do
    nvr --servername "$servername" --remote-send ":lua require 'bweave.utils'.setColorscheme()<CR>"
  done
fi
