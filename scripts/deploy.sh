#!/bin/bash

set -eu

# vim 9.1.0327 からは XDG_CONFIG_HOME に置けるみたい -> TODO: mise でインストールする?
# https://github.com/vim/vim/commit/c9df1fb35a1866901c32df37dd39c8b39dbdb64a
ln -sf "${HOME}"/.dotfiles/config/vim/.vimrc "${HOME}"/.vimrc

mkdir -p "${HOME}"/.config/zellij
ln -sf "${HOME}"/.dotfiles/config/zellij/config.kdl "${HOME}"/.config/zellij/config.kdl

mkdir -p "${HOME}"/.config/git
ln -sf "${HOME}"/.dotfiles/config/git/config "${HOME}"/.config/git/config

mkdir -p "${HOME}"/.config/nvim
ln -sf "${HOME}"/.dotfiles/config/nvim/init.lua "${HOME}"/.config/nvim/init.lua

mkdir -p "${HOME}"/.config/mise
ln -sf "${HOME}"/.dotfiles/config/mise/config.toml "${HOME}"/.config/mise/config.toml

if [ "$(uname)" = "Darwin" ]; then
  ln -sf "${HOME}"/.dotfiles/config/shell/.zshrc "${HOME}"/.zshrc
  # shellcheck disable=SC1090
  source ~/.zshrc

elif [ "$(uname)" = "Linux" ]; then
  # shellcheck disable=SC2016
  echo 'eval "$(~/.local/bin/mise activate bash)"' >>~/.bashrc
  # shellcheck disable=SC2016
  echo 'source "$HOME/.rye/env"' >>~/.bashrc
  # shellcheck disable=SC1090
  source ~/.bashrc
fi
