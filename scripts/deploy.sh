#!/bin/bash

set -eu

source_config_dir="${HOME}"/.dotfiles/xdg_config
target_config_dir="${HOME}"/.config

mkdir -p "$target_config_dir"
for item in "$source_config_dir"/*; do
  base_item=$(basename "$item")
  link_name="$target_config_dir/$base_item"
  ln -s "$item" "$link_name"
done

if [ "$(uname)" = "Darwin" ]; then
  mkdir -p "${HOME}"/.local/state/zsh "${HOME}"/.cache/zsh
  if ! grep -q 'export ZDOTDIR="$HOME"/.config/zsh' /etc/zshenv; then
    echo 'export ZDOTDIR="$HOME"/.config/zsh' | sudo tee -a /etc/zshenv
  fi

elif [ "$(uname)" = "Linux" ]; then
  echo 'source "$HOME/.dotfiles/config/.bashrc.local"' >>~/.bashrc
  source ~/.bashrc
fi
