#!/usr/bin/env bash
set -e

bbin install https://github.com/bhauman/clojure-mcp-light.git --tag v0.2.1 --as clj-nrepl-eval --main-opts '["-m" "clojure-mcp-light.nrepl-eval"]'
bbin install https://github.com/bhauman/clojure-mcp-light.git --tag v0.2.1 --as clj-paren-repair --main-opts '["-m" "clojure-mcp-light.paren-repair"]'

(cd /tmp && curl -sLO https://raw.githubusercontent.com/greglook/cljstyle/main/util/install-cljstyle)
chmod +x /tmp/install-cljstyle
/tmp/install-cljstyle --dir ~/.local/bin
