#!/bin/bash

DOT_FILES=(.gitconfig .zshrc .vimrc .vim .latexmkrc)
for file in "${DOT_FILES[@]}"; do
  ln -sf "$HOME"/dotfiles/config/"$file" "$HOME"/"$file"
done
