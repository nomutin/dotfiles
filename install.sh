#!/bin/bash

set -eu

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

# Install git
install_git() {
  if [[ "$(uname)" == "Darwin" ]] && ! xcode-select -p &>/dev/null; then
    log_info "Setting up MacOS prerequisites..."
    xcode-select --install
  fi
}

# Clone repository if it doesn't exist
clone_repo() {
  DOTFILES_DIR="${HOME}/.dotfiles"
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
    log_info "mise not found in PATH, installing"
    curl https://mise.run | sh
  fi

  # Symlink the entire mise config directory so mise discovers
  # [dotfiles], [bootstrap.*], [shell_alias] etc.
  DOTFILES_DIR="${HOME}/.dotfiles"
  XDG_CONFIG_DIR="${HOME}/.config"
  src_dir="${DOTFILES_DIR}/xdg_config/mise"
  dst_dir="${XDG_CONFIG_DIR}/mise"
  if [ -d "${src_dir}" ] && [ ! -e "${dst_dir}" ]; then
    mkdir -p "${XDG_CONFIG_DIR}"
    log_info "Linking mise config directory"
    ln -s "${src_dir}" "${dst_dir}"
  fi

  log_info "Installing dependencies with mise..."
  MISE_EXPERIMENTAL=true "${HOME}/.local/bin/mise" bootstrap -y
}

main() {
  install_git
  clone_repo
  setup_mise
  log_info "Dotfiles setup completed successfully."
}

main "$@"
