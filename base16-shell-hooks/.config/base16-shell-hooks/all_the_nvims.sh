#!/bin/bash

for socket in /tmp/nvimsocket*; do
  if [ -S "$socket" ]; then
    remote_send=":colorscheme base16-$BASE16_THEME<cr>"
    "$(which nvim)" --server "$socket" --remote-send "$remote_send"
  fi
done
