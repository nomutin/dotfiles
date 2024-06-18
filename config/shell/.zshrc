#!/bin/bash

# zsh settings
if [ "$0" = "zsh" ]; then
    autoload -U compinit
    compinit
fi

HISTFILE=~/.zsh_history
HISTSIZE=99999
export SAVEHIST=99999

# Apple Silicon or Rosetta2
ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
    export BREWx86_BASE=/opt/brew_x86
    export BREW_BASE=/opt/homebrew
    export PATH=${BREWx86_BASE}/bin:${BREWx86_BASE}/sbin${PATH:+:${PATH}}
    export PATH=${BREW_BASE}/bin:${BREW_BASE}/sbin${PATH:+:${PATH}}
fi
if [ "$ARCH" = "x86_64" ]; then
    export BREW_BASE=/opt/brew_x86
    export PATH=${PATH//¥/homebrew¥//¥/brew_x86¥/}
fi
alias x86='arch -x86_64 zsh'
alias arm='arch -arm64 zsh'

# terminal color
alias grep='grep --color=auto'
alias ls='ls --color=auto'
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export CLICOLOR=1
export LSCOLORS=GxGxBxDxCxEgEdxbxgxcxd

# shellcheck disable=SC1091
eval "$(~/.local/bin/mise activate zsh)"
source "$HOME/.rye/env"
