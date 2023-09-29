#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

LOMBOK_DIR="$HOME/.local/java/lombok"
LOMBOK_PATH="$LOMBOK_DIR/lombok.jar"
LOMBOK_DOWNLOAD_URL="https://projectlombok.org/downloads/lombok-1.18.30.jar"

if [[ ! -f "$LOMBOK_PATH" ]]; then
  echo "Downloading lombok from $LOMBOK_DOWNLOAD_URL"
  mkdir -p "$LOMBOK_DIR"
  http GET "$LOMBOK_DOWNLOAD_URL" > "$LOMBOK_PATH"
else
  echo "Lombok already exist in $LOMBOK_PATH, skipping..."
fi

