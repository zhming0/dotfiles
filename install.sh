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
    brew update
    brew upgrade
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
  coreutils \
  bat \
  fish \
  yarn \
  libpq \
  kubernetes-cli \
  kops \
  watchman \
  httpie \
  fzf \
  fd \
  ctop \
  mkcert \
  clojure/tools/clojure \
  borkdude/brew/clj-kondo \
  asdf

brew install --cask qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv qlimagesize webpquicklook quicklookase qlvideo

# Install fzf's key binding
$(brew --prefix)/opt/fzf/install

bash ./fish/setup.sh
bash ./nvim/setup.sh
./rust/setup.sh
./tmux/setup.sh

exec -l $SHELL
