<div align="center">

# .dotfiles

Minimal dotfiles for my `macOS` and `Linux`.

![platform](https://img.shields.io/badge/platform-macOS%20|%20Linux-blue)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/nomutin/dotfiles)
[![ci](https://github.com/nomutin/dotfiles/actions/workflows/ci.yaml/badge.svg)](https://github.com/nomutin/dotfiles/actions/workflows/ci.yaml)
[![lint](https://github.com/nomutin/dotfiles/actions/workflows/lint.yaml/badge.svg)](https://github.com/nomutin/dotfiles/actions/workflows/lint.yaml)

</div>

```shell
bash -c "$(curl https://raw.githubusercontent.com/nomutin/dotfiles/master/scripts/install.sh)"
```

## Apps

- Shell - [bash](https://www.gnu.org/software/bash/)
  - [bashrc](./config/bashrc)
  - Built-in to most platforms
- CLI Tool Manager - [mise](https://mise.jdx.dev/)
  - [config](./xdg_config/mise/config.toml)
  - Nothing is installed by default. Editing [config](./xdg_config/mise/config.toml) is required
- App Manager - [Homebrew](https://brew.sh)
  - [Brewfile](./config/Brewfile)
  - For macOS apps (not CLI tools)
- Terminal Emulator - [Alacritty](https://alacritty.org/)
  - [config](./xdg_config/alacritty/alacritty.toml)
  - Installed via Homebrew
- Terminal Multiplexer - [zellij](https://zellij.dev)
  - [config](./xdg_config/zellij/config.kdl)
  - Installed via mise
- Text Editor - [vim](https://www.vim.org) / [neovim](https://neovim.io)
  - [vimrc](./config/vimrc)
  - Shared settings
  - Manual install required
