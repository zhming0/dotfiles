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
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install \
  vim \
  neovim \
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
  gnupg \
  asdf \
  shellcheck \
  maven \
  helm

# brew install --cask qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv qlimagesize webpquicklook quicklookase qlvideo

asdf plugin add nodejs || true
asdf plugin add java || true

# 16.0.0 support both intel and arm Mac
asdf install nodejs 16.0.0
asdf global nodejs 16.0.0

npm i -g bash-language-server

# Liberica has ARM support and their lite jvm fits my use case more
asdf install java liberica-lite-11.0.11+9
asdf global java liberica-lite-11.0.11+9

# Install fzf's key binding
$(brew --prefix)/opt/fzf/install

bash ./fish/setup.sh
bash ./nvim/setup.sh
./rust/setup.sh
./tmux/setup.sh
./go/setup.sh

exec -l $SHELL
