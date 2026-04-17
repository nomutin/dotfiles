#!/bin/bash

set -eu

DOTFILES_DIR="${HOME}/.dotfiles"
XDG_CONFIG_DIR="${HOME}/.config"

RESET="\033[0m"
GREEN="\033[32m"
YELLOW="\033[33m"

# Log info message with green color
log_info() {
  echo -e "${GREEN}[INFO]${RESET} $1"
}

# Log skip message with yellow color
log_skip() {
  echo -e "${YELLOW}[SKIP]${RESET} $1"
}

# Create symbolic link if target does not exist
create_symlink() {
  if [ -e "$2" ] || [ -L "$2" ]; then
    log_skip "Target exists, skipping: $2"
  else
    log_info "Creating symlink: $2 -> $1"
    ln -s "$1" "$2"
  fi
}

# Clone repository if it doesn't exist
clone_repo() {
  if [ ! -d "${DOTFILES_DIR}" ]; then
    log_info "Cloning dotfiles into ${DOTFILES_DIR}..."
    git clone https://github.com/nomutin/dotfiles.git "${DOTFILES_DIR}"
  else
    log_skip "Dotfiles repository already exists at ${DOTFILES_DIR}."
  fi
}

# Install mise if not already installed
setup_mise() {
  if ! command -v mise >/dev/null 2>&1; then
    log_info "Installing mise..."
    curl https://mise.run | sh
  fi
  mise_cmd="eval \"\$(~/.local/bin/mise activate bash)\""
  profile="${HOME}/.bash_profile"
  if [ ! -f "${profile}" ] || ! grep -Fxq "${mise_cmd}" "${profile}"; then
    log_info "Adding mise activation to .bash_profile"
    echo "${mise_cmd}" >>"${profile}"
  fi
  log_info "Installing dependencies with mise..."
  mise install -yq
}

# Deploy all XDG config files
deploy_xdg_configs() {
  mkdir -p "${XDG_CONFIG_DIR}"
  for item in "${DOTFILES_DIR}/xdg_config/"*; do
    base_item=$(basename "${item}")
    create_symlink "${item}" "${XDG_CONFIG_DIR}/${base_item}"
  done
}

# Setup for MacOS
setup_macos() {
  if [[ "$(uname)" != "Darwin" ]]; then
    return
  fi
  log_info "Setting up MacOS prerequisites..."
  if ! (xcode-select -p &>/dev/null); then
    xcode-select --install
  fi
  if ! (type 'brew' >/dev/null 2>&1); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

main() {
  setup_macos
  clone_repo
  deploy_xdg_configs
  setup_mise
  log_info "Dotfiles setup completed successfully."
}

main "$@"
