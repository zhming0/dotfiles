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
ln -sfv $BASEDIR/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish

# Tmux
ln -sfv $BASEDIR/tmux/tmux.conf ~/.tmux.conf


# Git
ln -sfv $BASEDIR/git/gitignore ~/.gitignore
