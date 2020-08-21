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

alias paths="echo $PATH | tr ':' '\n'"

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

#html
export PATH=$HOME/.nodebrew/current/bin:$PATH
alias brsync='browser-sync start --server --directory --files "**/*"'
