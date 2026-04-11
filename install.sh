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

# Deploy all dot config files to $HOME as dotfiles
deploy_dot_configs() {
  for item in "${DOTFILES_DIR}/dot_config/"*; do
    base_item=$(basename "${item}")
    target_file="${HOME}/.${base_item}"
    source_line="source \"\$HOME/.dotfiles/dot_config/${base_item}\""

    if [ -L "${target_file}" ]; then
      current_link=$(readlink "${target_file}")
      if [ "${current_link}" = "${item}" ]; then
        log_skip "${target_file} is already a symlink to dotfiles config, skipping."
      else
        log_info "${target_file} is a different symlink, updating to point to dotfiles config."
        ln -sf "${item}" "${target_file}"
      fi
    elif [ -e "${target_file}" ]; then
      if ! grep -Fxq "${source_line}" "${target_file}"; then
        log_info "Appending source command to existing ${target_file}"
        echo "${source_line}" >>"${target_file}"
      else
        log_skip "${target_file} already sources the dotfiles config."
      fi
    else
      create_symlink "${item}" "${target_file}"
    fi
  done

  if [ -e "${HOME}/.bashrc" ]; then
    log_info "Sourcing .bashrc..."
    # shellcheck source=/dev/null
    source "${HOME}/.bashrc"
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
  if ! command -v mo >/dev/null 2>&1; then
    log_info "mole not found, installing..."
    curl -fsSL https://raw.githubusercontent.com/tw93/mole/main/install.sh | bash
  fi
}

main() {
  setup_macos
  clone_repo
  deploy_xdg_configs
  deploy_dot_configs
  install_mise
  log_info "Dotfiles setup completed successfully."
}

main "$@"
