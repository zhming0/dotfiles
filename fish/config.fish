# PG's CLI tools 
# https://stackoverflow.com/a/49689589
set -xg PATH /usr/local/Cellar/libpq/11.5/bin $PATH

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
set -xg FZF_DEFAULT_COMMAND 'fd --type f'
set -xg FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
