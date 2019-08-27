#!/usr/bin/env bash
echo Configuring mac

set -e

if [[ $(xcode-select --version) ]]; then
  echo Xcode command tools already installed
else
  echo "Installing Xcode commandline tools"
  $(xcode-select --install)
fi

if [[ $(brew --version) ]] ; then
    echo "Attempting to update Homebrew"
    # brew update
else
    echo "Attempting to install Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install \
  git \
  tmux \
  jq \
  ansible \
  awscli \
  terraform \
  telnet \
  ripgrep \
  fish

brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzip qlimagesize webpquicklook suspicious-package quicklookase qlvideo

if ! grep -Fxq "/usr/local/bin/fish" /etc/shells
then
	echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
fi;
chsh -s $(which fish)

