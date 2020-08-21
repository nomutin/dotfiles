#!/bin/bash

#"===== brew install ====="
if !(type 'brew' > /dev/null 2>&1); then
    xcode-select --install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap caskroom/cask
fi	

#"===== brew install functions ====="
brew install pyenv docker

#"===== startup apps =====
brew cask install iterm2 clipy coteditor skim docker

#"===== make dotfiles alias ====="
DOT_FILES=(.gitconfig .zshrc .latexmkrc)
for file in ${DOT_FILES[@]};
    ln -s $HOME/dotfiles/$file $HOME/$file
done

#"===== setting for matplotlib =====
mkdir $HOME/.matplotlib
 ln -sf $HOME/dotfiles/matplotlibrc $HOME/.matplotlib/matplotlibrc
 
 #"===== MacBook settings =====
defaults write "Apple Global Domain" com.apple.mouse.scaling 10
defaults write com.apple.dock autohide-time-modifier -int 0 && killall Dock
