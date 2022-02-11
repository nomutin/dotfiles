# Apple Silicon用 Latexセットアップファイル

# 事前設定
brew install ghostscript

# basictexのインストール
brew install --cask basictex
sudo tlmgr update --self --all
sudo tlmgr install paper a4 latexmk collection-langjapanese collection-fontsrecommended collection-fontutils listings multirow mhchem siunitx enumitem
