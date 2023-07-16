#!/bin/zsh

set -u

files=(
    scripts/deploy.sh
    scripts/init.sh
    scripts/install.sh
    scripts/shellckeck.sh
    scripts/actionlint.sh
)
for file in "${files[@]}"
do
    shellcheck "${file}"
done
