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

# Check if macOS is in dark mode
dark_mode_status=$(osascript -e 'tell app "System Events" to tell appearance preferences to get dark mode')

if [ "$dark_mode_status" = "true" ]; then
  theme="monokai-pro-light"
else
  theme="everforest"
fi

"$HOME"/bin/omakub $theme >/dev/null 2>&1
