# .dotfiles

[![macOS](https://github.com/nomutin/dotfiles/actions/workflows/health-macos.yaml/badge.svg)](https://github.com/nomutin/dotfiles/actions/workflows/health-macos.yaml)
[![Ubuntu](https://github.com/nomutin/dotfiles/actions/workflows/health-ubuntu.yaml/badge.svg)](https://github.com/nomutin/dotfiles/actions/workflows/health-ubuntu.yaml)
[![Distribution Links](https://github.com/nomutin/dotfiles/actions/workflows/deploy-distribution-links.yaml/badge.svg)](https://github.com/nomutin/dotfiles/actions/workflows/deploy-distribution-links.yaml)

```shell
curl -fsSL https://nomutin.github.io/dotfiles/install.sh | bash
```

Settings for:

- [vim](./.config/vim/vimrc) (text editor)
- [tmux](./.config/tmux/tmux.conf) (multiplexer)
- [mise](./.config/mise/config.toml) (CLI manager)
- [ghostty](./.config/ghostty/config.ghostty) (terminal emulator)
- **(unused)** ~~[neovim](./.config/nvim/init.lua) (text editor)~~
- **(unused)** ~~[alacritty](./.config/alacritty/alacritty.toml) (terminal emulator)~~
- **(unused)** ~~[zellij](./.config/zellij/config.kdl) (terminal multiplexer)~~

<details>

<summary>App-Specific Installation</summary>

### vim

```bash
curl -fsSL https://nomutin.github.io/dotfiles/.config/vim/vimrc -o ~/.vimrc
```

### tmux

```bash
curl -fsSL https://nomutin.github.io/dotfiles/.config/tmux/tmux.conf -o ~/.tmux.conf
```

</details>

