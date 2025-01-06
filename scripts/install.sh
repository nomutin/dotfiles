#!/bin/bash

set -e

# ===== Install repo =====
if [ ! -d "${HOME}"/.dotfiles ]; then
  git clone https://github.com/nomutin/dotfiles.git "${HOME}"/.dotfiles
else
  echo "dotfiles already exists"
  exit 1
fi

# ===== Install mise =====
if ! (type 'mise' >/dev/null 2>&1); then
  curl https://mise.run | sh
fi

# ===== Deploy xdg-based configs =====
xdg_config_dir="${HOME}"/.config
if [ ! -d "${xdg_config_dir}" ]; then
  mkdir -p "${xdg_config_dir}"
fi

for item in "${HOME}"/.dotfiles/xdg_config/*; do
  base_item=$(basename "$item")
  link_name="${xdg_config_dir}/$base_item"
  if [ -f "$link_name" ]; then
    echo "$link_name exists, skipping"
    continue
  fi
  ln -s "$item" "$link_name"
done

# ===== Deploy bashrc =====
if [ -f "${HOME}"/.bashrc ]; then
  echo 'source "$HOME/.dotfiles/config/bashrc"' >>~/.bashrc
else
  ln -s "${HOME}"/.dotfiles/config/bashrc "${HOME}"/.bashrc
fi
source "${HOME}"/.bashrc

# ===== Install dependencies =====
mise install -y

# ===== Set up Macos =====
# if [ "$(uname)" = "Darwin" ]; then
#   bash "{HOME}"/.dotfiles/scripts/macos.sh
# fi
