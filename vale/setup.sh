#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__vale_config_path="$__dir/vale.ini"

mkdir -p ~/.local/share/vale/

ln -sfv "$__vale_config_path" ~/.vale.ini

vale sync --config="$__vale_config_path"
