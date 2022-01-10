#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Fish
mkdir -p ~/.config/fish/functions/
mkdir -p ~/.config/fish/local_functions/ # Functions that won't be managed by this repo
ln -sfv $BASEDIR/fish/config.fish ~/.config/fish/config.fish
ln -sfv $BASEDIR/fish/fish_plugins ~/.config/fish/fish_plugins
ln -sfv $BASEDIR/fish/functions/* ~/.config/fish/functions

# Tmux
ln -sfv $BASEDIR/tmux/tmux.conf ~/.tmux.conf

# Ripgrep
mkdir -p ~/.config/ripgrep
ln -sfv $BASEDIR/fish/ripgrep.conf ~/.config/ripgrep/ripgrep.conf

# Fd
mkdir -p ~/.config/fd
ln -sfv $BASEDIR/fish/fdignore ~/.config/fd/ignore

# Git
ln -sfv $BASEDIR/git/gitignore ~/.gitignore
