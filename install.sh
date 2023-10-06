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
  chatblade

# brew install --cask qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv qlimagesize webpquicklook quicklookase qlvideo

asdf plugin add nodejs || true
asdf plugin add java || true
asdf plugin add terraform || true

# 16.0.0 support both intel and arm Mac
asdf install nodejs 16.10.0
asdf global nodejs 16.10.0

asdf install java openjdk-21
asdf global java openjdk-21

asdf install terraform latest
asdf global terraform latest

bash ./fish/setup.sh
bash ./nvim/setup.sh
./rust/setup.sh
./tmux/setup.sh
./go/setup.sh
./ruby/setup.sh

# Some helm related setup
helm plugin install https://github.com/databus23/helm-diff
helm plugin install https://github.com/jkroepke/helm-secrets --version v4.1.1
helm plugin install https://github.com/helm/helm-mapkubeapis

./bin/gh-cargo-install.sh --git crate-ci/typos --target x86_64-apple-darwin --tag v1.12.12

git config --global diff.tool nvimdiff
git config --global difftool.prompt false
git config --global rerere.enabled true

exec -l $SHELL
