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

mkdir -p "${HOME}"/.config/zsh
ln -sf "${HOME}"/.dotfiles/config/zsh/.zshrc "${HOME}"/.config/zsh/.zshrc

if [ "$(uname)" = "Darwin" ]; then

  if ! grep -q 'export ZDOTDIR="$HOME"/.config/zsh' /etc/zshenv; then
    echo 'export ZDOTDIR="$HOME"/.config/zsh' | sudo tee -a /etc/zshenv
  fi
  mkdir -p "${HOME}"/.local/state/zsh "${HOME}"/.cache/zsh

elif [ "$(uname)" = "Linux" ]; then
  echo 'eval "$(~/.local/bin/mise activate bash)"' >>~/.bashrc
  echo 'source "$HOME/.rye/env"' >>~/.bashrc
  # shellcheck disable=SC1090
  source ~/.bashrc
fi
