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

| #                    | App                                                      | Config                                | Comment                                    |
| :------------------: | :------------------------------------------------------: | :-----------------------------------: | ------------------------------------------ |
| Shell                | [bash](https://www.gnu.org/software/bash/)               | [📂](./config/bashrc)                 | Built-in to most platforms                 |
| CLI Manager          | [mise](https://mise.jdx.dev/)                            | [📂](./xdg_config/mise/config.toml)   | Config editing required                    |
| GUI Manager          | [Homebrew-cask](https://brew.sh)                         | [📂](./config/Brewfile)               | For macOS apps                             |
| Terminal Multiplexer | [GNU Screen](https://www.gnu.org/software/screen/)       | [📂](./xdg_config/screen/screenrc)    | Built-in to most platforms                 |
| Text Editor          | [vim](https://www.vim.org)                               | [📁](./config/vimrc)                  | Shared settings<br>Manual install required |

## 🗑️ Configs no longer used

| App       | Config                                                                 | Comment                                     |
| :-------: | :--------------------------------------------------------------------: | ------------------------------------------- |
| Neovim    | [🔗](https://gist.github.com/nomutin/512f27a7b8bf8969a43d9ff0483938da) | Less portable than vim                      |
| Alacritty | [🔗](https://gist.github.com/nomutin/6f7640e77576ef585c9fb7dc15ff9f13) | `Terminal.app` is sufficient in MacOS Tahoe |
| Ghostty   | [🔗](https://gist.github.com/nomutin/b626b919d8dcabdff6da39e342a8f16a) | `Terminal.app` is sufficient in MacOS Tahoe |
| Zellij    | [🔗](https://gist.github.com/nomutin/ddf64ec5602727f43d81357648adb189) | `screen` is sufficient for me               |
