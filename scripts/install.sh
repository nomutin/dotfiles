#!/bin/bash

set -eu

cd "${HOME}"

# Install my dotfiles
if [ ! -d .dotfiles ]; then
  git clone https://github.com/nomutin/dotfiles.git .dotfiles
fi

cd .dotfiles

# Deploy dotfiles
ln -sf "${HOME}"/.dotfiles/config/.gitconfig "${HOME}"/.gitconfig
ln -sf "${HOME}"/.dotfiles/config/.vimrc "${HOME}"/.vimrc
ln -sf "${HOME}"/.dotfiles/config/zellij-confg.toml "${HOME}"/.config/zellij/config.toml
ln -sf "${HOME}"/.dotfiles/config/neovim-config.lua "${HOME}"/.config/nvim/init.lua
ln -sf "${HOME}"/.dotfiles/config/mise-config.kdl "${HOME}"/.config/mise/config.kdl

if [ "$0" = "zsh" ]; then
  ln -sf "${HOME}"/.dotfiles/config/.profile "${HOME}"/.zprofile
  ln -sf "${HOME}"/.dotfiles/config/.zshrc "${HOME}"/.zshrc
  # shellcheck disable=SC1090
  source ~/.zshrc
elif [ "$0" = "bash" ]; then
  ln -sf "${HOME}"/.dotfiles/config/.profile "${HOME}"/.profile
  ln -sf "${HOME}"/.dotfiles/config/.bashrc "${HOME}"/.bashrc
  # shellcheck disable=SC1090
  source ~/.bashrc
fi

# Install mise
if ! (type 'mise' >/dev/null 2>&1); then
  curl https://mise.run | sh
fi

# Set up macOS
if [ "$(uname)" = "Darwin" ]; then
  make init-macos
fi

