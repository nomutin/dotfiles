#!/bin/bash

#"===== brew install ====="
if !(type 'brew' > /dev/null 2>&1); then
    xcode-select --install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi	

#"===== install nightly-itrem2 ====="
if [ -e /Applications/iTerm.app ]; then
    :
else
    open -a 'Safari' "https://www.iterm2.com/nightly/latest"
    https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/Hack.zip
fi

#"===== dein install ====="
if [ -e ~/.vim/dein/repos/github.com/Shougo/dein.vim ]; then
    :
else
    mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
    git clone https://github.com/Shougo/dein.vim.git     ~/.vim/dein/repos/github.com/Shougo/dein.vim
    echo 'dein.vim install'
fi

#"===== make dotfiles alias ====="
DOT_FILES=(.vimrc .gitconfig .bash_profile .zshrc)
for file in ${DOT_FILES[@]};
do
    if [ -e $HOME/$file ]; then
        :
    else
        ln -s $HOME/dotfiles/$file $HOME/$file
    fi
done

#"===== vim settings ====="
VIM_OPTIONS=(rc colors)
for option in ${VIM_OPTIONS[@]};
do
    if [ -e $HOME/.vim/$option/ ]; then
        :
    else
        mkdir $HOME/.vim/$option
    fi

    for file in $(ls $HOME/dotfiles/.vim/$option);
        do
            ln -s $HOME/dotfiles/.vim/$option/$file $HOME/.vim/$option/$file
        done
done

#"===== dock setting=====
defaults write com.apple.dock autohide-time-modifier -int 0

#"===== install python =====
brew install pyenv python3

#"===== setting for tex =====
brew tap caskroom/cask
brew cask install skim
#sudo tlmgr install latexmk

#"===== startup apps =====
brew cask install clipy alfred coteditor insomniax touchswitcher

#"===== setting for matplotlib =====
mkdir $HOME/.matplotlib
 ln -s $HOME/dotfiles/matplotlibrc $HOME/.matplotlib/matplotlibrc
