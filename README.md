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

## Main Apps

| #                    | App                                                | Config                                                           |
| -------------------- | -------------------------------------------------- | ---------------------------------------------------------------- |
| Shell                | [bash](https://www.gnu.org/software/bash/)         | [./config/bashrc](./config/bashrc)                               |
| CLI Manager          | [mise](https://mise.jdx.dev/)                      | [./xdg_config/mise/config.toml](./xdg_config/mise/config.toml)   |
| GUI Manager          | [Homebrew-cask](https://brew.sh)                   | [./config/Brewfile](./config/Brewfile)                           |
| Terminal Multiplexer | [GNU Screen](https://www.gnu.org/software/screen/) | [./xdg_config/screen/screenrc](./xdg_config/screen/screenrc)     |
| Text Editor          | [vim](https://www.vim.org)                         | [./config/vimrc](./config/vimrc)                                 |

## 🗑️ Configs no longer used

| App       | Config |
| :-------: | :---: |
| Neovim    | [https://gist.github.com/nomutin/512f27a7b8bf8969a43d9ff0483938da](https://gist.github.com/nomutin/512f27a7b8bf8969a43d9ff0483938da) |
| Alacritty | [https://gist.github.com/nomutin/6f7640e77576ef585c9fb7dc15ff9f13](https://gist.github.com/nomutin/6f7640e77576ef585c9fb7dc15ff9f13) |
| Ghostty   | [https://gist.github.com/nomutin/b626b919d8dcabdff6da39e342a8f16a](https://gist.github.com/nomutin/b626b919d8dcabdff6da39e342a8f16a) |
| Zellij    | [https://gist.github.com/nomutin/ddf64ec5602727f43d81357648adb189](https://gist.github.com/nomutin/ddf64ec5602727f43d81357648adb189) |
