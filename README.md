<div align="center">

# .dotfiles

Dotfiles for my own `macOS` and non-root `Linux`.

![platform](https://img.shields.io/badge/platform-macOS%20|%20Linux-blue)
[![Lint](https://github.com/nomutin/dotfiles/actions/workflows/lint.yaml/badge.svg)](https://github.com/nomutin/dotfiles/actions/workflows/lint.yaml)

</div>

```shell
bash -c "$(curl https://raw.githubusercontent.com/nomutin/dotfiles/master/scripts/install.sh)"
```

## Contents

| App Group | App | Platform | Config |
| --- | --- | --- | :---: |
| Shell | [zsh](https://www.zsh.org) | ![platform](https://img.shields.io/badge/platform-macOS-blue) | [🔍](./config/shell/.zshrc) |
|  | [bash](https://www.gnu.org/software/bash/) | ![platform](https://img.shields.io/badge/platform-Linux-blue) | |
| Package Manager | [Homebrew](https://brew.sh) | ![platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-blue) | [🔍](./Brewfile) |
|  | [mise](https://mise.jdx.dev/) | ![platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-blue) | [🔍](./config/mise/config.toml) |
| Terminal Emulator | [iterm2](https://iterm2.com) | ![platform](https://img.shields.io/badge/platform-macOS-blue) | |
| Terminal Multiplexer | [zellij](https://zellij.dev) | ![platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-blue) | [🔍](./config/zellij/config.kdl) |
| Text Editor | [neovim](https://neovim.io) | ![platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-blue) | [🔍](./config/neovim/README.md) |
| | [vim](https://www.vim.org) | ![platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-blue) | [🔍](./config/vim/.vimrc) |
