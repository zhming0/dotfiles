# Ensure Brew and binaries that it's managing in the $PATH
if test (arch) = "arm64"
  set brew_path "/opt/homebrew/bin/brew"
else
  set brew_path (which brew)
end
eval ($brew_path shellenv)

# PG's CLI tools
# https://stackoverflow.com/a/49689589
# Only add libpq tools to PATH if pg_dump is not already available
# When pg_dump is installed, it's likely that the system already have pg cli tools installed in some other way
if not command -q pg_dump
  set LIBPQ_PATH (fd -t d --full-path . (brew --prefix)"/Cellar/libpq" | grep bin)
  set -xg PATH $LIBPQ_PATH $PATH
end

# Rust tools
fish_add_path $HOME/.cargo/bin

# Load local non-git managed configuration
if test -e ~/.config/fish/local.fish
  source ~/.config/fish/local.fish
end

# Auto load non-git managed local functions
set --prepend fish_function_path "~/.config/fish/local_functions"

alias vim nvim
alias vimdiff 'nvim -d'
set -xg EDITOR nvim

# Rebind fish.fzf's default keymapping
# run: fzf_configure_bindings --help to learn more
fzf_configure_bindings --directory=\cf

# Ripgrep
set -xg RIPGREP_CONFIG_PATH ~/.config/ripgrep/ripgrep.conf

# Bison
# According to brew
# bison is keg-only, which means it was not symlinked into /opt/homebrew,
# because macOS already provides this software and installing another version in
# parallel can cause all kinds of trouble.
set -gx LDFLAGS "-L"(brew --prefix)"/opt/bison/lib"

abbr --add p pnpm
abbr --add px pnpx

# This envvar is used by my jdt.ls neovim setup
set -xg JDTLS_JVM_ARGS "-javaagent:$HOME/.local/java/lombok/lombok.jar"

# Git Abbrs
abbr --add gaa "git add -A"
abbr --add gs "git switch"
abbr --add gst "git status -u"
abbr --add gp "git pull"
abbr --add gco "git checkout"
abbr --add gm "git commit"
abbr --add gma "git commit -am"
abbr --add gd "git difftool"

# K8s abbrs
abbr --add kctx "kubectl config use-context"
abbr --add kns "kubectl config set-context --current --namespace"
abbr --add k "kubectl"

# JJ abbrs
abbr --add jjn "jj git fetch && jj new main" # JJ new
abbr --add jjsync "jj git fetch && jj rebase -b @ -d main" # JJ sync/rebase the whole branch
abbr --add jjgp "jj git push --allow-new"
abbr --add jjgpa "jj git push --all"
abbr --add jjbc "jj b c"


export CONTAINERS_MACHINE_PROVIDER=applehv

# A directory for my custom scripts.
fish_add_path $HOME/bin

# Checkout https://github.com/atuinsh/atuin
# This is shell history + sqlite
atuin init fish | source

git-town completions fish | source

jj util completion fish | source

direnv hook fish | source

set -U fish_greeting
function fish_greeting
  echo "(ง •̀_•́)ง  ==>  (ง •̀_•́)ง  ==>  ¯\_(ツ)_/¯  ==>  _(:3」∠)_" | lolcat
end

# pnpm
set -gx PNPM_HOME "/Users/ming/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# uv
fish_add_path "/Users/ming/.local/bin"

# zoxide
zoxide init fish | source

# DuckDB
fish_add_path "/Users/ming/.duckdb/cli/latest"
