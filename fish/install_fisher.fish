#!/usr/bin/env fish

curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

fisher update

# Check https://github.com/IlanCosman/tide/issues/304 to see if there is a better way.
echo 2 1 2 2 1 1 1 2 1 3 3 2 2 y | tide configure >/dev/null
