#!/usr/bin/env bash

set -e

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mise use -g go@latest

brew tap golangci/tap
brew install golangci/tap/golangci-lint
