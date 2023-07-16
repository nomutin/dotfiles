DOT_FILES=(.gitconfig .zshrc .gitignore .vimrc .vim .latexmkrc)
for file in ${DOT_FILES[@]}; do
	ln -sf $HOME/dotfiles/$file $HOME/$file
done
