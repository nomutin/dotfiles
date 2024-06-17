#!/bin/bash

set -eu

ln -sf "${HOME}"/.dotfiles/config/git/.gitconfig "${HOME}"/.gitconfig
ln -sf "${HOME}"/.dotfiles/config/vim/.vimrc "${HOME}"/.vimrc

mkdir -p "${HOME}"/.config/zellij
ln -sf "${HOME}"/.dotfiles/config/zellij/config.kdl "${HOME}"/.config/zellij/config.kdl

mkdir -p "${HOME}"/.config/nvim
ln -sf "${HOME}"/.dotfiles/config/neovim/init.lua "${HOME}"/.config/nvim/init.lua

mkdir -p "${HOME}"/.config/mise
ln -sf "${HOME}"/.dotfiles/config/mise/config.toml "${HOME}"/.config/mise/config.toml

ln -sf "${HOME}"/.dotfiles/config/shell/.profile "${HOME}"/.profile

