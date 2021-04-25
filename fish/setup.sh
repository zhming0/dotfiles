#!/usr/bin/env bash

set -e

# Trying to set fish as default
if ! grep -Fxq "/usr/local/bin/fish" /etc/shells
then
	echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
fi;
chsh -s $(which fish)

# Install fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
