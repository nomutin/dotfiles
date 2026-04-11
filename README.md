<div align="center">

# .dotfiles

Minimal dotfiles for my `macOS` and `Linux`.

![platform](https://img.shields.io/badge/platform-macOS%20|%20Linux-blue)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/nomutin/dotfiles)
[![ci](https://github.com/nomutin/dotfiles/actions/workflows/ci.yaml/badge.svg)](https://github.com/nomutin/dotfiles/actions/workflows/ci.yaml)

</div>

```shell
bash -c "$(curl https://raw.githubusercontent.com/nomutin/dotfiles/master/install.sh)"
```

Settings for:

- [bash](./dot_config/bashrc) (shell)
- [vim](./xdg_config/vim/vimrc) (text editor)
- [tmux](./xdg_config/tmux/tmux.conf) (multiplexer)
- [mise](./xdg_config/mise/config.toml) (CLI manager)
- [cutler](./xdg_config/cutler/config.toml) (macOS systems)


## App-Specific

- bash

    ```bash
    curl -s https://raw.githubusercontent.com/nomutin/dotfiles/master/dot_config/bashrc -o ~/.bashrc
    ```

- vim

    ```bash
    curl -s https://raw.githubusercontent.com/nomutin/dotfiles/master/xdg_config/vim/vimrc -o ~/.vimrc
    ```

- tmux

    ```bash
    curl -s https://raw.githubusercontent.com/nomutin/dotfiles/master/xdg_config/tmux/tmux.conf -o ~/.tmux.conf
    ```

