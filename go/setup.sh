#!/usr/bin/env bash

set -e

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


asdf plugin add golang || true

asdf install golang 1.20.2
asdf global golang 1.20.2

brew tap golangci/tap
brew install golangci/tap/golangci-lint
