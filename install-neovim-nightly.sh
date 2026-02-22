#!/usr/bin/env bash

set -e

platform=$(
  case "$OSTYPE" in
  linux*)
    echo "linux64"
    ;;
  darwin*)
    echo "macos-arm64"
    ;;
  *)
    exit 1
    ;;
  esac
)

cd /tmp || exit
rm -rf "./nvim-$platform.tar.gz"
rm -rf "./nvim-$platform/"
curl -fsSL -O "https://github.com/neovim/neovim/releases/download/nightly/nvim-$platform.tar.gz"
if [ "$platform" == "macos" ]; then
  xattr -c "./nvim-$platform.tar.gz" # avoid macOS not developer signed warnings
fi
tar xzvf "./nvim-$platform.tar.gz"
cd /usr/local/ || exit
sudo rm -rf "./nvim-$platform"
sudo mv "/tmp/nvim-$platform" "/usr/local/nvim-$platform"
# sudo ln -sf "/usr/local/nvim-$platform/bin/nvim" /usr/local/bin/nvim
mkdir -p "$HOME/.local/bin"
sudo ln -sf "/usr/local/nvim-$platform/bin/nvim" "$HOME/.local/bin/nvim"
echo "Done!"
