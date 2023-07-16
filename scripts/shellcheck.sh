#!/bin/bash

set -u

files=(
  scripts/deploy.sh
  scripts/init.sh
  scripts/install.sh
  scripts/shellcheck.sh
)

for file in "${files[@]}"; do
  shellcheck "${file}"
done
