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
| Shell | [zsh](https://www.zsh.org) | Host | [🔍](./xgd_config/zsh/.zshrc) |
|  | [bash](https://www.gnu.org/software/bash/) | Guest | [🔍](./config/.bashrc.local) |
| Package Manager | [Homebrew](https://brew.sh) | Host | [🔍](./config/Brewfile) |
|  | [mise](https://mise.jdx.dev/) | Host/Guest | [🔍](./xgd_config/mise/config.toml) |
| Terminal Emulator | [Alacritty](https://alacritty.org/) | Host | [🔍](./xgd_config/alacritty/alacritty.toml) |
| Terminal Multiplexer | [zellij](https://zellij.dev) | Host/Guest | [🔍](./xgd_config/zellij/config.kdl) |
| Text Editor | [neovim](https://neovim.io) | Host/Guest | [🔍](./xgd_config/nvim/README.md) |
| | [vim](https://www.vim.org) | Host/Guest | [🔍](./xgd_config/vim/vimrc) |
