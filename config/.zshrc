#!/bin/bash

# zsh settings
autoload -U compinit
compinit

HISTFILE=~/.zsh_history
HISTSIZE=99999
export SAVEHIST=99999

# Apple Silicon or Rosetta2
alias x86='arch -x86_64 zsh'
alias arm='arch -arm64 zsh'

# terminal color
alias grep='grep --color=auto'
alias ls='ls --color=auto'
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export CLICOLOR=1
export LSCOLORS=GxGxBxDxCxEgEdxbxgxcxd

# command
alias brup='brew update && brew upgrade'
function cdmk {
	mkdir "$1"
	cd "$1" || exit
	return 0
}

