#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# This needs to match $ASDF_GEM_DEFAULT_PACKAGES_FILE
# Checkout https://github.com/asdf-vm/asdf-ruby#default-gems
ln -sfv "$__dir/default-gems" ~/.config/default-gems

export ASDF_GEM_DEFAULT_PACKAGES_FILE="$HOME/.config/default-gems" # This is just for the install command below

asdf plugin add ruby || true
asdf install ruby 3.2.2
asdf global ruby 3.2.2

