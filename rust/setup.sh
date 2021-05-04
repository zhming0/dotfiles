#!/usr/bin/env fish

curl https://sh.rustup.rs -sSf | sh

source $HOME/.cargo/env

# This will install RLS and its helpers
# Although CoC-RLS can install it automatically, I'd like to manually install it for clarity
rustup component add rls rust-analysis rust-src
