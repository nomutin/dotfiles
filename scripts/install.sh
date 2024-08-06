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
src="${HOME}/.dotfiles/xdg_config"
tgt="${HOME}/.config"
mkdir -p "$tgt"
for item in "$src"/*; do
  ln -s "$item" "$tgt/$(basename "$item")"
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
