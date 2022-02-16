ARCH=$(uname -m)
 if [ "$ARCH" = "arm64" ]; then
   export BREWx86_BASE=/opt/brew_x86
   export BREW_BASE=/opt/homebrew
   export PATH=${BREWx86_BASE}/bin:${BREWx86_BASE}/sbin${PATH:+:${PATH}}
   export PATH=${BREW_BASE}/bin:${BREW_BASE}/sbin${PATH:+:${PATH}}
 fi
 if [ "$ARCH" = "x86_64" ]; then
   export BREW_BASE=/opt/brew_x86
   # export PATH=${BREW_BASE}/bin:${BREW_BASE}/sbin${PATH:+:${PATH}}
   export PATH=${PATH//¥/homebrew¥//¥/brew_x86¥/}
 fi

# Pyenv
 export PYENV_ROOT="${HOME}/.pyenv"
 if [ -x "${PYENV_ROOT}/bin" ]; then
   export PATH=${PYENV_ROOT}/bin:${PATH}
 fi