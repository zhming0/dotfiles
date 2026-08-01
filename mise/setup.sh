#!/usr/bin/env bash

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p ~/.config/mise
ln -sfv "$BASEDIR/config.toml" ~/.config/mise/config.toml
mise trust "$BASEDIR/config.toml"
mise install
