#!/bin/bash

set -eu

mkdir -p "${HOME}"/.config/zellij
ln -sf "${HOME}"/.dotfiles/config/zellij/config.kdl "${HOME}"/.config/zellij/config.kdl

mkdir -p "${HOME}"/.config/git
ln -sf "${HOME}"/.dotfiles/config/git/config "${HOME}"/.config/git/config

mkdir -p "${HOME}"/.config/nvim
ln -sf "${HOME}"/.dotfiles/config/nvim/init.lua "${HOME}"/.config/nvim/init.lua

mkdir -p "${HOME}"/.config/mise
ln -sf "${HOME}"/.dotfiles/config/mise/config.toml "${HOME}"/.config/mise/config.toml

mkdir -p "${HOME}"/.config/wezterm
ln -sf "${HOME}"/.dotfiles/config/wezterm/wezterm.lua "${HOME}"/.config/wezterm/wezterm.lua

mkdir -p "${HOME}"/.config/vim
ln -sf "${HOME}"/.dotfiles/config/vim/vimrc "${HOME}"/.config/vim/vimrc

if [ "$(uname)" = "Darwin" ]; then
  ln -sf "${HOME}"/.dotfiles/config/zsh/.zshrc "${HOME}"/.zshrc
  # shellcheck disable=SC1090
  source ~/.zshrc
  mkdir -p "${HOME}"/.local/state/zsh "${HOME}"/.cache/zsh

elif [ "$(uname)" = "Linux" ]; then
  # shellcheck disable=SC2016
  echo 'eval "$(~/.local/bin/mise activate bash)"' >>~/.bashrc
  # shellcheck disable=SC2016
  echo 'source "$HOME/.rye/env"' >>~/.bashrc
  # shellcheck disable=SC1090
  source ~/.bashrc
fi
