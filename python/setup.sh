#!/usr/bin/env bash

set -e

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sfv "$__dir/default-python-packages" "$HOME/.config/default-python-packages"

asdf plugin add python || true
asdf set --home python 3.13.2
