#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__vale_config_path="$__dir/vale.ini"
__vale_style_path="$HOME/.local/share/vale/styles"
__vale_tech_voca_dir="$__vale_style_path/config/vocabularies/Tech"

mkdir -p "$__vale_style_path"
mkdir -p "$__vale_tech_voca_dir"

ln -sfv "$__vale_config_path" ~/.vale.ini
ln -sfv "$__dir/accept.txt" "$__vale_tech_voca_dir/accept.txt"

vale sync --config="$__vale_config_path"
