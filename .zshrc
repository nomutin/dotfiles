autoload -U compinit
compinit

HISTFILE=~/.zsh_history
HISTSIZE=9999
SAVEHIST=9999


#自作基本コマンド
alias brup='brew update && brew upgrade'

function cdmk {
	mkdir $1
	cd $1
	return 0
}


function clone {
	git clone https://github.com/nomutin/$1.git
}

# C
function cco {
	LS=`ls *.c`
	gcc $LS
	return 0
}

alias cru='./a.out'
export C_INCLUDE_PATH='/Users/nomura/.pyenv/versions/3.8.5/include/python3.8'

# python
export PIPENV_VENV_IN_PROJECT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"
eval "$(pyenv init -)"


#html
export PATH=$HOME/.nodebrew/current/bin:$PATH
alias brsync='browser-sync start --server --directory --files "**/*"'

#latex
function lset {
	cp -r '/Users/nomura/dotfiles/texlive/template' $PWD
	mv template $1
}



alias lmk='docker run -v $(pwd):/root/work -it texlive latexmk --pvc ./main.tex'
alias lmc='docker run -v $(pwd):/root/work -it texlive latexmk -c ./main.tex && rm main.dvi && rm main.synctex.gz'
# docker rm `docker ps -a -q`

