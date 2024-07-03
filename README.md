<div align="center">

# .dotfiles

Dotfiles for my host `macOS` and guest `Linux`.

![platform](https://img.shields.io/badge/platform-macOS%20|%20Linux-blue)
[![Lint](https://github.com/nomutin/dotfiles/actions/workflows/lint.yaml/badge.svg)](https://github.com/nomutin/dotfiles/actions/workflows/lint.yaml)

</div>

```shell
bash -c "$(curl https://raw.githubusercontent.com/nomutin/dotfiles/master/scripts/install.sh)"
```

## Contents

| App Group | App | Host/Guest | Config |
| --- | --- | --- | :---: |
| Shell | [zsh](https://www.zsh.org) | Host | [🔍](./config/shell/.zshrc) |
|  | [bash](https://www.gnu.org/software/bash/) | Guest | |
| Package Manager | [Homebrew](https://brew.sh) | Host | [🔍](./Brewfile) |
|  | [mise](https://mise.jdx.dev/) | Host/Guest | [🔍](./config/mise/config.toml) |
| Terminal Emulator | [Wezterm](https://wezfurlong.org/wezterm/index.html) | Host | [🔍](./config/wezterm/wezterm.lua) |
| Terminal Multiplexer | [zellij](https://zellij.dev) | Host/Guest | [🔍](./config/zellij/config.kdl) |
| Text Editor | [neovim](https://neovim.io) | Host/Guest | [🔍](./config/neovim/README.md) |
| | [vim](https://www.vim.org) | Host/Guest | [🔍](./config/vim/.vimrc) |
