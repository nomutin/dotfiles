# zsh settings
autoload -U compinit
compinit

HISTFILE=~/.zsh_history
HISTSIZE=99999
SAVEHIST=99999

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

# terminal color
alias grep='grep --color=auto'
alias ls='ls --color=auto'
export MANPAGER="less -R --use-color -Dd+r -Du+b"

# command
alias x86='arch -x86_64 zsh'
alias arm='arch -arm64 zsh'
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

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

export PATH="$PYENV_ROOT/shims:$PATH"
if [ -x "$(which pyenv)" ]; then
    eval "$(pyenv init -zsh)"
fi

# pipenv
export PIPENV_VENV_IN_PROJECT=1

# c++
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/zlib/lib/pkgconfig"
export LIBGL_ALWAYS_INDIRECT=1

# html
export PATH=$HOME/.nodebrew/current/bin:$PATH
alias brsync='browser-sync start --server --directory --files "**/*"'

# latex
alias lmk='latexmk -pvc ./main.tex'
alias lmc='latexmk -c ./main.tex && rm -f main.dvi && rm -f main.bbl && rm -f main.synctex.gz'


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/nomura/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/nomura/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/nomura/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/nomura/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
