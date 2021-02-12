#!/bin/bash

#"===== brew install ====="
if !(type 'brew' > /dev/null 2>&1); then
    xcode-select --install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap caskroom/cask
fi	

#"===== startup apps =====
brew cask install iterm2 clipy skim deepl coteditor alfred

#"===== make dotfiles alias ====="
DOT_FILES=(.gitconfig .zshrc .latexmkrc .gitignore .vimrc .vim)
for file in ${DOT_FILES[@]};
do
    ln -sf $HOME/dotfiles/$file $HOME/$file
done
source ~/.zshrc

#"===== setting for matplotlib =====
mkdir $HOME/.matplotlib
ln -sf $HOME/dotfiles/matplotlibrc $HOME/.matplotlib/matplotlibrc
 
#"===== MacBook settings =====
defaults write com.apple.dock autohide-time-modifier -int 0 && killall Dock

#===== docker settings =====
brew install docker
brew cask install docker

#"===== node.js settigs =====
brew install nodebrew
mkdir -p ~/.nodebrew/src
nodebrew install-binary stable
nodebrew use stable
npm install -g browser-sync

#"===== python setting ====="
brew install pyenv
pyenv install 3.8.5
pyenv global 3.8.5
pip install pipenv
