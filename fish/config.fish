# Ensure Brew and binaries that it's managing in the $PATH
if test (arch) = "arm64"
  set brew_path "/opt/homebrew/bin/brew"
else
  set brew_path (which brew)
end
eval ($brew_path shellenv)

# PG's CLI tools
# https://stackoverflow.com/a/49689589
set LIBPQ_PATH (fd -t d --full-path . (brew --prefix)"/Cellar/libpq" | grep bin)
set -xg PATH $LIBPQ_PATH $PATH

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

# Colors
set fish_color_command brwhite --bold
set fish_color_cwd green
set fish_color_match brmagenta

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

# Checkout https://github.com/asdf-vm/asdf-ruby#default-gems
# set -xg ASDF_GEM_DEFAULT_PACKAGES_FILE "$HOME/.config/default-gems"

# Checkout https://github.com/asdf-community/asdf-python
# set -xg ASDF_GEM_DEFAULT_PACKAGES_FILE "$HOME/.config/default-python-packages"

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

# The following are copied from https://asdf-vm.com/guide/getting-started.html
#if test -z $ASDF_DATA_DIR
#    set _asdf_shims "$HOME/.asdf/shims"
#else
#    set _asdf_shims "$ASDF_DATA_DIR/shims"
#end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
#set -gx --prepend PATH $_asdf_shims
#set --erase _asdf_shims

# Java per https://github.com/halcyon/asdf-java#java_home
#. ~/.asdf/plugins/java/set-java-home.fish

# Golang
#. ~/.asdf/plugins/golang/set-env.fish

# pnpm
set -gx PNPM_HOME "/Users/ming/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# uv
fish_add_path "/Users/ming/.local/bin"
