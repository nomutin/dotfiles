#!/bin/bash

set -eu

RESET="\033[0m"
GREEN="\033[32m"

# Log info message with green color
log_info() {
  echo -e "${GREEN}[INFO]${RESET} $1"
}

# Install git
install_git() {
  if [[ "$(uname)" == "Darwin" ]] && ! xcode-select -p &>/dev/null; then
    log_info "Setting up MacOS prerequisites..."
    xcode-select --install
  fi
}

# Install mise if not already installed
setup_mise() {
  if ! command -v mise >/dev/null 2>&1; then
    log_info "mise not found in PATH, installing"
    curl https://mise.run | sh
    export PATH="$HOME/.local/bin:$PATH"
  fi
  log_info "Bootstraping..."
  mise bootstrap \
      --from https://github.com/nomutin/dotfiles.git \
      --from-dir ~/.dotfiles \
      --config-dir .config/mise \
      --skip packages,macos-defaults
}

main() {
  install_git
  setup_mise
  log_info "Dotfiles setup completed successfully."
}

main "$@"
