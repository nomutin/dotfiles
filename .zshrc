autoload -U compinit
compinit

HISTFILE=~/.zsh_history
HISTSIZE=100
SAVEHIST=100


#自作基本コマンド
alias brup='brew update && brew upgrade'

function cdmk {
	mkdir $1
	cd $1
	return 0
}


# C
function cco {
	LS=`ls *.c`
	gcc $LS
	return 0
}

alias cru='./a.out'

# python
export PIPENV_VENV_IN_PROJECT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# latexmk
function lmk {
	if [ -f main.tex ]; then
		latexmk -pvc main.tex
	else
		latexmk -pvc
	fi
}

function lmc {
	if [ -f main.tex ]; then
		latexmk -c main.tex
	else
		latexmk -c
	fi
}



