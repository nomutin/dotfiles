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

| #                    | App                                                      | Config | Comment                                    | 
| :------------------: | :------------------------------------------------------: | :----: | ------------------------------------------ | 
| Shell                | [bash](https://www.gnu.org/software/bash/)               | [📂](./config/bashrc)                 | Built-in to most platforms                 | 
| CLI Manager          | [mise](https://mise.jdx.dev/)                            | [📂](./xdg_config/mise/config.toml)   | Editing config is required                 | 
| GUI Manager          | [Homebrew-cask](https://brew.sh)                         | [📂](./config/Brewfile)               | For macOS apps | 
| Terminal Emulator    | [Ghostty](https://ghostty.org)                           | [📂](./xdg_config/ghostty/config)     | Installed via Homebrew-cask                | 
| Terminal Multiplexer | [zellij](https://zellij.dev)                             | [📂](./xdg_config/zellij/config.kdl)  | Installed via mise                         | 
| Text Editor          | [vim](https://www.vim.org) / [neovim](https://neovim.io) | [📁](./config/vimrc)                  | Shared settings<br>Manual install required | 
