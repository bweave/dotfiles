#!/bin/bash

case "$OSTYPE" in
  darwin*)
    terminal-notifier \
      -title "Base16" \
      -message "$BASE16_THEME theme set!" \
    ;;
esac
