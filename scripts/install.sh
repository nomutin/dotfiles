#!/bin/bash

set -eu

cd "${HOME}"

if [ ! -d .dotfiles ]; then
  git clone https://github.com/nomutin/dotfiles.git .dotfiles
fi

cd .dotfiles

make deploy

# shellcheck disable=SC1090
source ~/.zshrc

if ! (type 'brew' >/dev/null 2>&1); then
  xcode-select --install
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

make init
