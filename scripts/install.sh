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
  local source="$1"
  local target="$2"
  if [ -e "${target}" ] || [ -L "${target}" ]; then
    log_skip "Target exists, skipping: ${target}"
  else
    log_info "Creating symlink: ${target} -> ${source}"
    ln -s "${source}" "${target}"
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
install_mise() {
  if ! command -v mise >/dev/null 2>&1; then
    log_info "Installing mise..."
    curl https://mise.run | sh
  else
    log_skip "Mise is already installed."
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

# Deploy Bash configuration
deploy_bashrc() {
  local bashrc_file="${HOME}/.bashrc"
  local bashrc_source="${HOME}/.dotfiles/config/bashrc"
  if [ -L "${bashrc_file}" ]; then
    log_skip ".bashrc is a symlink, skipping."
  elif [ -e "${bashrc_file}" ]; then
    cat "${bashrc_source}" >>"${bashrc_file}"
    log_info "Appended source command to existing .bashrc"
  else
    create_symlink "${bashrc_source}" "${bashrc_file}"
  fi
  log_info "Sourcing .bashrc..."
  # shellcheck source=/dev/null
  source "${bashrc_file}"
}

# Deploy .profile
deploy_profile() {
  local profile_file="${HOME}/.profile"
  local profile_source="${HOME}/.dotfiles/config/profile"
  if [ -L "${profile_file}" ]; then
    log_skip ".profile is a symlink, skipping."
  elif [ -e "${profile_file}" ]; then
    cat "${profile_source}" >>"${profile_file}"
    log_info "Appended source command to existing .profile"
  else
    create_symlink "${profile_source}" "${profile_file}"
  fi
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
  if ! (mole -p &>/dev/null); then
    curl -fsSL https://raw.githubusercontent.com/tw93/mole/main/install.sh | bash
  fi
}

main() {
  setup_macos
  clone_repo
  deploy_xdg_configs
  deploy_bashrc
  deploy_profile
  install_mise
  log_info "Dotfiles setup completed successfully."
}

main "$@"
