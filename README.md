<div align="center">

# .dotfiles

Minimal dotfiles for my `macOS` and `Linux`.

![platform](https://img.shields.io/badge/platform-macOS%20|%20Linux-blue)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/nomutin/dotfiles)
[![ci](https://github.com/nomutin/dotfiles/actions/workflows/ci.yaml/badge.svg)](https://github.com/nomutin/dotfiles/actions/workflows/ci.yaml)

</div>

```shell
curl -fsSL https://nomutin.github.io/dotfiles/install.sh | bash
```

Settings for:

- [bash](./dot_config/bashrc) (shell)
- [vim](./xdg_config/vim/vimrc) (text editor)
- [tmux](./xdg_config/tmux/tmux.conf) (multiplexer)
- [mise](./xdg_config/mise/config.toml) (CLI manager)
- [cutler](./xdg_config/cutler/config.toml) (macOS systems)

<details>

<summary>App-Specific Installation</summary>

### bash

```bash
curl -fsSL https://nomutin.github.io/dotfiles/dot_config/bashrc -o ~/.bashrc
```

### vim

```bash
curl -fsSL https://nomutin.github.io/dotfiles/xdg_config/vim/vimrc -o ~/.vimrc
```

### tmux

```bash
curl -fsSL https://nomutin.github.io/dotfiles/xdg_config/tmux/tmux.conf -o ~/.tmux.conf
```

</details>
