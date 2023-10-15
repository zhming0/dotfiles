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
set -xg PATH $HOME/.cargo/bin $PATH

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

source (brew --prefix asdf)/libexec/asdf.fish

# Java per https://github.com/halcyon/asdf-java#java_home
. ~/.asdf/plugins/java/set-java-home.fish

# Golang
. ~/.asdf/plugins/golang/set-env.fish

set -xg ASDF_GOLANG_MOD_VERSION_ENABLED true

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
set -xg ASDF_GEM_DEFAULT_PACKAGES_FILE "$HOME/.config/default-gems"

# Git Abbrs
abbr --add gaa "git add -A"
abbr --add gs "git status -u"
abbr --add gp "git pull"
abbr --add gco "git checkout"
abbr --add gm "git commit"
abbr --add gma "git commit -am"
abbr --add gd "git difftool"

# K8s abbrs
abbr --add kctx "kubectl config use-context"
abbr --add kns "kubectl config set-context --current --namespace"
abbr --add k "kubectl"

