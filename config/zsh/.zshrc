#!/bin/zsh

# ===== XGD PATH =====
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
export LESSHISTFILE="$XDG_STATE_HOME"/less/history

# ===== zsh settings =====
autoload -U compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

export HISTFILE="$XDG_STATE_HOME"/zsh/history
export HISTSIZE=999
export SAVEHIST=99999

# ===== Processar =====
alias x86='arch -x86_64 zsh'
alias arm='arch -arm64 zsh'

# ===== Terminal Color =====
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# ===== ls aliases =====
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# ===== Plugins =====
eval $(/opt/homebrew/bin/brew shellenv)
eval "$(~/.local/bin/mise activate zsh)"
# shellcheck disable=SC1091
source "$HOME/.rye/env"
