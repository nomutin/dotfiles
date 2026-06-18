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

  # Create symlinks for mise config so mise can discover dotfiles,
  # bootstrap tasks, shell aliases, etc. before running commands
  DOTFILES_DIR="${HOME}/.dotfiles"
  XDG_CONFIG_DIR="${HOME}/.config"
  for config in config config.macos config.development; do
    src="${DOTFILES_DIR}/xdg_config/mise/${config}.toml"
    dst="${XDG_CONFIG_DIR}/mise/${config}.toml"
    if [ -f "${src}" ] && [ ! -e "${dst}" ]; then
      mkdir -p "${XDG_CONFIG_DIR}/mise"
      log_info "Linking mise config: ${config}.toml"
      ln -s "${src}" "${dst}"
    fi
  done

  log_info "Installing dependencies with mise..."
  "${HOME}/.local/bin/mise" install -yq
  MISE_EXPERIMENTAL=true "${HOME}/.local/bin/mise" bootstrap -y
}

main() {
  install_git
  clone_repo
  setup_mise
  log_info "Dotfiles setup completed successfully."
}

main "$@"
