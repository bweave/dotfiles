#!/bin/bash

cd /tmp || exit
# make sure we've got a clean slate
rm -f ./neovim-nightly.tar.gz
rm -rf ./neovim-nightly

# download and untar the source code
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
tar xzvf ./neovim-linux64.tar.gz

# build from source
cd /tmp/neovim-linux64 || exit
rm -r build/  # clear the CMake cache in case there's anything stale
make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
make install

# link it so it's in PATH
cd "$HOME/neovim" || exit
ln -sf "$HOME/neovim/bin/nvim" "${HOMEBREW_PREFIX:-/usr/local}/bin/nvim"
