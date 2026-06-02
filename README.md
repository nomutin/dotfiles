# .dotfiles

[![macOS](https://github.com/nomutin/dotfiles/actions/workflows/health-macos.yaml/badge.svg)](https://github.com/nomutin/dotfiles/actions/workflows/health-macos.yaml)
[![Ubuntu](https://github.com/nomutin/dotfiles/actions/workflows/health-ubuntu.yaml/badge.svg)](https://github.com/nomutin/dotfiles/actions/workflows/health-ubuntu.yaml)
[![Distribution Links](https://github.com/nomutin/dotfiles/actions/workflows/deploy-distribution-links.yaml/badge.svg)](https://github.com/nomutin/dotfiles/actions/workflows/deploy-distribution-links.yaml)

```shell
curl -fsSL https://nomutin.github.io/dotfiles/install.sh | bash
```

Settings for:

- [vim](./xdg_config/vim/vimrc) (text editor)
- [tmux](./xdg_config/tmux/tmux.conf) (multiplexer)
- [mise](./xdg_config/mise/config.toml) (CLI manager)
- [ghostty](./xdg_config/ghostty/config.ghostty) (terminal emulator)
- [cutler](./xdg_config/cutler/config.toml) (MacOS setup)
- **(unused)** ~~[neovim](./xdg_config/nvim/init.lua) (text editor)~~
- **(unused)** ~~[alacritty](./xdg_config/alacritty/alacritty.toml) (terminal emulator)~~
- **(unused)** ~~[zellij](./xdg_config/zellij/config.kdl) (terminal multiplexer)~~

<details>

<summary>App-Specific Installation</summary>

### vim

```bash
curl -fsSL https://nomutin.github.io/dotfiles/xdg_config/vim/vimrc -o ~/.vimrc
```

### tmux

```bash
curl -fsSL https://nomutin.github.io/dotfiles/xdg_config/tmux/tmux.conf -o ~/.tmux.conf
```

</details>

