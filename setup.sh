#!/bin/bash

#"===== brew install ====="
xcode-select --install

if !(type 'brew' > /dev/null 2>&1); then
    xcode-select --install
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi	

#"===== startup apps =====
brew install --cask iterm2 clipy deepl coteditor alfred swiftdefaultappsprefpane visual-studio-code rectangle keyboardcleantool dozer mathpix-snipping-tool google-drive biscuit

#"===== make dotfiles alias ====="
DOT_FILES=(.gitconfig .zshrc .gitignore .vimrc .vim .latexmkrc)
for file in ${DOT_FILES[@]};
do
    ln -sf $HOME/dotfiles/$file $HOME/$file
done
source ~/.zshrc

#"===== MacBook settings =====
defaults write com.apple.dock autohide-time-modifier -int 0 && killall Dock