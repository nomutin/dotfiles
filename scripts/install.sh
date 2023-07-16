#!/bin/zsh

set -eu

cd "${HOME}"

if !(type 'brew' > /dev/null 2>&1); then
    xcode-select --install
    /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    export PATH=$PATH:/opt/homebrew/bin
fi	

if [ ! -d dotfiles ]; then
    git clone https://github.com/nomutin/dotfiles.git
fi

cd dotfiles

make deploy

make init
