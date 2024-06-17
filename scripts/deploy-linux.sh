#!/bin/bash

set -eu

cd "${HOME}/.dotfiles"

ln -sf "${HOME}"/.dotfiles/config/.gitconfig "${HOME}"/.gitconfig
ln -sf "${HOME}"/.dotfiles/config/vim/.vimrc "${HOME}"/.vimrc
ln -sf "${HOME}"/.dotfiles/config/zellij/confg.kdl "${HOME}"/.config/zellij/config.kdl
ln -sf "${HOME}"/.dotfiles/config/neovim/init.lua "${HOME}"/.config/nvim/init.lua
ln -sf "${HOME}"/.dotfiles/config/mise/config.toml "${HOME}"/.config/mise/config.toml

ln -sf "${HOME}"/.dotfiles/config/.profile "${HOME}"/.profile
ln -sf "${HOME}"/.dotfiles/config/.bashrc "${HOME}"/.bashrc

