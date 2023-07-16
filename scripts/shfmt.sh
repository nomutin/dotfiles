#!/bin/bash

set -u

files=(
	scripts/deploy.sh
	scripts/init.sh
	scripts/install.sh
	scripts/shellcheck.sh
	scripts/actionlint.sh
	scripts/shfmt.sh
)
for file in "${files[@]}"; do
	shfmt -w "${file}"
done
