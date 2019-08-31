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
