#!/bin/bash

BASEDIR="$(pwd)"

# Vim
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s {BASEDIR}/.vimrc ~

# Fish
mkdir -p ~/.config/fish/functions/
ln -s {BASEDIR}/fish_prompt.fish ~/.config/fish/functions
