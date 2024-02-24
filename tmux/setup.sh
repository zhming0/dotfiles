#!/usr/bin/env bash

set -e

tpm_dir="$HOME/.tmux/plugins/tpm"
# Install tmux plugin manager
if ! [ -d "$tpm_dir" ]; then
  git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
else
  echo "Skipping cloning tpm..."
fi
