#!/bin/bash

set -e

check_command() {
  local name=$1
  if ! command -v "$name" &> /dev/null; then
    echo "Error: $name not found or not executable."
    exit 1
  fi
  echo "Command: $name is available."
}

check_alias() {
  local alias_name=$1
  if ! type "$alias_name" &> /dev/null; then
    echo "Error: $alias_name alias not found or not executable. bashrc may not be sourced."
    exit 1
  fi
  echo "$alias_name alias is available (bashrc sourced)."
}

check_alias "ll"
check_command "mise"
check_command "nvim"
check_command "zellij"
check_command "fzf"
check_command "rg"
