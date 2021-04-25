#!/bin/bash
# Create some common symlinks

BASEDIR="$(pwd)"

# Vim
if [[ ! -d  ~/.vim/bundle/Vundle.vim ]]; then
  mkdir -p ~/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
ln -sfv $BASEDIR/vim/vimrc ~/.vimrc

# Fish
mkdir -p ~/.config/fish/functions/
ln -sfv $BASEDIR/fish/config.fish ~/.config/fish/config.fish
ln -sfv $BASEDIR/fish/fish_plugins ~/.config/fish/fish_plugins

# Tmux
ln -sfv $BASEDIR/tmux/tmux.conf ~/.tmux.conf

# Ripgrep
mkdir -p ~/.config/ripgrep
ln -sfv $BASEDIR/fish/ripgrep.conf ~/.config/ripgrep/ripgrep.conf

# Git
ln -sfv $BASEDIR/git/gitignore ~/.gitignore
