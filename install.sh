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
  vim \
  git \
  tmux \
  jq \
  ansible \
  awscli \
  terraform \
  telnet \
  ripgrep \
  fish \
  yarn \
  libpq \
  kubernetes-cli \
  watchman \
  httpie

brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv qlimagesize webpquicklook quicklookase qlvideo

bash ./fish/setup.sh

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

# Invall Google Cloud SDK
curl https://sdk.cloud.google.com | bash

exec -l $SHELL
