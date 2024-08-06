#!/bin/bash

set -eu

cd "${HOME}"

# ===== Install repo =====
if [ ! -d .dotfiles ]; then
  git clone https://github.com/nomutin/dotfiles.git .dotfiles
fi

# ===== Install mise =====
if ! (type 'mise' >/dev/null 2>&1); then
  curl https://mise.run | sh
fi

# ===== Deploy xdg-based configs =====
source_config_dir="${HOME}"/.dotfiles/xgd_config
target_config_dir="${HOME}"/.config

mkdir -p "$target_config_dir"
for item in "$source_config_dir"/*; do
  base_item=$(basename "$item")
  link_name="$target_config_dir/$base_item"
  ln -s "$item" "$link_name"
done

# ===== Deploy bashrc =====
if [ -f "${HOME}"/.bashrc ]; then
  echo 'source "$HOME/.dotfiles/config/bashrc"' >>~/.bashrc
else
  ln -s "${HOME}"/.dotfiles/config/bashrc "${HOME}"/.bashrc
fi

# ===== Install dependencies =====
mise install -y

# ===== Set up Macos =====
if [ "$(uname)" = "Darwin" ]; then
  bash scripts/init_macos.sh
fi
