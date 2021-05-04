#!/usr/bin/env bash

set -e

# Trying to set fish as default
if ! grep -Fxq "$(which fish)" /etc/shells
then
  echo "Modifiying /etc/shells to include $(which fish)"
  echo "$(which fish)" | sudo tee -a /etc/shells
fi;
chsh -s $(which fish)

# Install fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install IlanCosman/tide
