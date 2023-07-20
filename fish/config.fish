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
git config --global diff.tool nvimdiff
git config --global difftool.prompt false
set -xg EDITOR nvim

# Let FZF to use FD instead of FIND by default
# so gitignore is respected, symlink followed, .git ignored
# fish.fzf comes with sane default so these are no longer needed.
#set -xg FZF_DEFAULT_COMMAND 'fd --hidden --type f --follow --exclude .git'
#set -xg FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# Rebind fish.fzf's default keymapping
# run: fzf_configure_bindings --help to learn more
fzf_configure_bindings --directory=\cf

# Colors
set fish_color_command brwhite --bold
set fish_color_cwd green
set fish_color_match brmagenta

# Golang
set -xg GOPATH $HOME/.go
set -xg PATH $GOPATH/bin $PATH

# Java per https://github.com/halcyon/asdf-java#java_home
. ~/.asdf/plugins/java/set-java-home.fish


# Ripgrep
set -xg RIPGREP_CONFIG_PATH ~/.config/ripgrep/ripgrep.conf

source (brew --prefix asdf)/libexec/asdf.fish

# Bison
# According to brew
# bison is keg-only, which means it was not symlinked into /opt/homebrew,
# because macOS already provides this software and installing another version in
# parallel can cause all kinds of trouble.
set -gx LDFLAGS "-L"(brew --prefix)"/opt/bison/lib"

alias p=pnpm
alias px=pnpx
