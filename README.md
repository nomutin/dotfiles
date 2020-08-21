# Nomutin's MacBook Pro Setup file
## 💻 実行コマンド
以下をクリーンインストール後のTerminalに貼り付け
```
git clone https://github.com/nomutin/dotfiles && sh dotfiles/setup.sh
```

## ✅ setup.shの項目
現在のsetup.shに記述してあるコマンドは，以下の項目

1. homebrew及びxcode-selectのインストール

2. スタートアップアプリのインストール

	現在(2020/8/20)は，caskを用いて以下のアプリをインストール

	- iterm2
	- sublime-text
	- docker (for latex)
	- clipy
	- skim (for latex)
	- deepl

3. ドットファイルのエイリアスの作成(.gitconfig .zshrc .latexmkrc .gitignore)

	.zshrcによってPATHを通しておく

4. 各種設定・インストール

	- matplotlib
	- Dock速度
	- docker
	- node.js
	- python
