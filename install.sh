#!/usr/bin/env bash
echo Configuring mac

set -e

if [[ $(xcode-select --version) ]]; then
  echo Xcode command tools already installed
else
  echo "Installing Xcode commandline tools"
  xcode-select --install
fi

if [[ $(brew --version) ]] ; then
    echo "Attempting to update Homebrew"
    brew update
    brew upgrade
else
    echo "Attempting to install Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)" # One-off setup, permanent setup is in fish config.
fi

brew install \
  neovim \
  git \
  cmake \
  lima \
  bison \
  tmux \
  jq \
  ansible \
  awscli \
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
  helm \
  bash-language-server \
  clojure-lsp/brew/clojure-lsp-native \
  terminal-notifier \
  sops \
  hashicorp/tap/terraform-ls \
  derailed/k9s/k9s \
  bash \
  helmfile \
  age \
  babashka/brew/neil \
  fairwindsops/tap/nova \
  pnpm \
  ariga/tap/atlas \
  mike-engel/jwt-cli/jwt-cli \
  chatblade \
  podman \
  difftastic \
  stats \
  int128/kubelogin/kubelogin \
  lolcat \
  atuin

# This is one-off, permanent setup is in fish config.
source "$(brew --prefix asdf)/libexec/asdf.sh"

asdf plugin add nodejs || true
asdf plugin add java || true
asdf plugin add terraform || true

asdf install nodejs 20.11.1
asdf global nodejs 20.11.1

asdf install java openjdk-21
asdf global java openjdk-21

asdf install terraform latest
asdf global terraform latest

asdf plugin-add direnv
asdf direnv setup --shell fish --version latest # This may not work on the first try
asdf global direnv 2.34.0

./fish/setup.sh
./nvim/setup.sh
./rust/setup.sh
./tmux/setup.sh
./go/setup.sh
./ruby/setup.sh

# Some helm related setup
helm plugin install https://github.com/databus23/helm-diff
helm plugin install https://github.com/jkroepke/helm-secrets --version v4.1.1
helm plugin install https://github.com/helm/helm-mapkubeapis

exec -l $SHELL
