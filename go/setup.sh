#!/usr/bin/env bash

set -e

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


asdf plugin add golang || true

asdf install golang 1.16.5
asdf global golang 1.16.5

go install golang.org/x/tools/gopls@v0.7.0
