#!/bin/bash

# Vim
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s .vimrc ~

# Fish
mkdir -p ~/.config/fish/functions/
ln -s fish_prompt.fish ~/.config/fish/functions
