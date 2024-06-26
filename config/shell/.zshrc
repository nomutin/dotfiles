#!/bin/bash

# zsh settings
if [ "$0" = "zsh" ]; then
    autoload -U compinit
    compinit
fi

HISTFILE=~/.zsh_history
HISTSIZE=99999
export SAVEHIST=99999

# Mac
eval $(/opt/homebrew/bin/brew shellenv)
alias x86='arch -x86_64 zsh'
alias arm='arch -arm64 zsh'

# terminal color
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Plugins
eval "$(~/.local/bin/mise activate zsh)"
# shellcheck disable=SC1091
source "$HOME/.rye/env"
