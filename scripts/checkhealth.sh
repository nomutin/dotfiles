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

check_command "mise"
check_command "nvim"
check_command "zellij"
check_command "fzf"
check_command "rg"
