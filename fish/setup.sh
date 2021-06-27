#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Trying to set fish as default
if ! grep -Fxq "$(which fish)" /etc/shells
then
  echo "Modifiying /etc/shells to include $(which fish)"
  echo "$(which fish)" | sudo tee -a /etc/shells
fi;

if ! [ "$SHELL" = "$(which fish)" ]
then
  echo "Modifying default shell to fish"
  chsh -s "$(which fish)"
fi;

"$__dir"/install_fisher.fish
