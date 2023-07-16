#!/bin/zsh

set -u

files=(
    scripts/deploy.sh
    scripts/init.sh
    scripts/install.sh
    scripts/shellckeck.sh
    scripts/actionlint.sh
    scripts/shfmt.sh
)
for file in "${files[@]}"
do
    shfmt "${file}"
done
