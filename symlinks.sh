#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Fish
mkdir -p ~/.config/fish/functions/
mkdir -p ~/.config/fish/local_functions/ # Functions that won't be managed by this repo
ln -sfv $BASEDIR/fish/config.fish ~/.config/fish/config.fish
ln -sfv $BASEDIR/fish/fish_plugins ~/.config/fish/fish_plugins
ln -sfv $BASEDIR/fish/functions/* ~/.config/fish/functions

# Tmux
ln -sfv $BASEDIR/tmux/tmux.conf ~/.tmux.conf

# Ripgrep
mkdir -p ~/.config/ripgrep
ln -sfv $BASEDIR/fish/ripgrep.conf ~/.config/ripgrep/ripgrep.conf

# Fd
mkdir -p ~/.config/fd
ln -sfv $BASEDIR/fish/fdignore ~/.config/fd/ignore

# Git
ln -sfv $BASEDIR/git/gitignore ~/.gitignore
ln -sfv $BASEDIR/git/gitconfig ~/.gitconfig

# Jujutsu
ln -sfv $BASEDIR/bin/jjpr.clj ~/bin/jjpr

# sst opencode
ln -sfv $BASEDIR/opencode/AGENTS.md ~/.config/opencode/AGENTS.md
ln -sfnv $BASEDIR/opencode/plugin ~/.config/opencode/plugin

# Claude Code
mkdir -p ~/.claude
ln -sfv $BASEDIR/claude/settings.json ~/.claude/settings.json
ln -sfv $BASEDIR/opencode/AGENTS.md ~/.claude/CLAUDE.md

# add-skill CLI
ln -sfv $BASEDIR/bin/add-skill.clj ~/bin/add-skill
