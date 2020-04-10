# PG's CLI tools
# https://stackoverflow.com/a/49689589
set LIBPQ_PATH (fd -t d --full-path . '/usr/local/Cellar/libpq' | grep bin)
set -xg PATH $LIBPQ_PATH $PATH

# Rust tools
set -xg PATH $HOME/.cargo/bin $PATH

if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

# Fundle configuration
fundle plugin 'edc/bass'

fundle init

# Load local non-git managed configuration
if test -e ~/.config/fish/local.fish
  source ~/.config/fish/local.fish
end

alias vim nvim
set -xg EDITOR nvim

# Let FZF to use FD instaed of FIND by default
# so gitignore is respected
set -xg FZF_DEFAULT_COMMAND 'fd --hidden --type f'
set -xg FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# Colors
set fish_color_command brwhite --bold
set fish_color_cwd green
set fish_color_match brmagenta

# Golang
set -xg GOPATH $HOME/.go
set -xg PATH $GOPATH/bin $PATH
