#!/bin/bash

filename="neovim-nightly"

cd /tmp || exit
# make sure we've got a clean slate
rm -f ./$filename.tar.gz
rm -rf ./$filename

# download and untar the source code
curl -fsSL -o $filename.tar.gz https://github.com/neovim/neovim/archive/refs/tags/nightly.tar.gz
tar xzvf ./$filename.tar.gz

# build from source
cd /tmp/$filename || exit
rm -rf build/  # clear the CMake cache in case there's anything stale
make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
make install

# link it so it's in PATH
mkdir -p "$HOME/neovim"
cd "$HOME/neovim" || exit
ln -sf "$HOME/neovim/bin/nvim" "${HOMEBREW_PREFIX:-/usr/local}/bin/nvim"
