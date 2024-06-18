#!/bin/bash

set -eu

cd "${HOME}"

# Install my dotfiles
if [ ! -d .dotfiles ]; then
  git clone https://github.com/nomutin/dotfiles.git .dotfiles
fi

# Install mise
if ! (type 'mise' >/dev/null 2>&1); then
  curl https://mise.run | sh
fi

cd .dotfiles

# Deploy 
make deploy

mise install -y

Set up macOS
if [ "$(uname)" = "Darwin" ]; then
  make init-macos
fi
