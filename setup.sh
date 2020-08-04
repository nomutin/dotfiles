#!/bin/bash

#"===== brew install ====="
if !(type 'brew' > /dev/null 2>&1); then
    xcode-select --install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap caskroom/cask
fi	

#"===== install nightly-itrem2 ====="
if !([ -e /Applications/iTerm.app ]); then
    open -a 'Safari' "https://www.iterm2.com/nightly/latest"
     % https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/Hack.zip
fi

#"===== dein install ====="
if !([ -e ~/.vim/dein/repos/github.com/Shougo/dein.vim ]); then
    mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
    git clone https://github.com/Shougo/dein.vim.git ~/.vim/dein/repos/github.com/Shougo/dein.vim
    echo 'dein.vim install'
fi

#"===== make dotfiles alias ====="
DOT_FILES=(.vimrc .gitconfig .zshrc .latexmkrc )
for file in ${DOT_FILES[@]};
do
    if !([ -e $HOME/$file ]); then
        ln -s $HOME/dotfiles/$file $HOME/$file
    fi
done

#"===== vim settings ====="
VIM_OPTIONS=(rc colors)
for option in ${VIM_OPTIONS[@]};
do
    if !([ -e $HOME/.vim/$option/ ]); then
         mkdir $HOME/.vim/$option
    fi

    for file in $(ls $HOME/dotfiles/.vim/$option);
        do
            ln -s $HOME/dotfiles/.vim/$option/$file $HOME/.vim/$option/$file
        done
done

#"===== install pyenv =====
if !(type 'pyenv' > /dev/null 2>&1); then
    brew install pyenv docker
fi	

#"===== startup apps =====
if !([ -e /Applications/clipy.app ]); then
    brew cask install clipy coteditor skim docker
fi

#"===== setting for matplotlib =====
mkdir $HOME/.matplotlib
 ln -s $HOME/dotfiles/matplotlibrc $HOME/.matplotlib/matplotlibrc
 
defaults write com.apple.dock autohide-time-modifier -int 0 && killall Dock