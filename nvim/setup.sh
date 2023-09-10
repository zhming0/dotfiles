#!/usr/bin/env bash

set -e

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Install nvim
brew install neovim

# Prepare config folder
mkdir -p ~/.config/nvim

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# ln -sfv $BASEDIR/init.vim ~/.config/nvim/init.vim

ln -sfv $BASEDIR/coc-settings.json ~/.config/nvim/coc-settings.json
ln -sfv $BASEDIR/lua ~/.config/nvim/lua
ln -sfv $BASEDIR/init.lua ~/.config/nvim/init.lua
ln -sfv $BASEDIR/lazy-lock.json ~/.config/nvim/lazy-lock.json

