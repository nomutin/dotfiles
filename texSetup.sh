# Apple Silicon用 Latexセットアップファイル

# 事前設定
brew install ghostscript

# basictexのインストール
brew install --cask basictex
sudo tlmgr update --self --all
sudo tlmgr install paper a4 latexmk collection-langjapanese collection-fontsrecommended collection-fontutils listings multirow mhchem siunitx enumitem

 # ヒラギノフォント埋め込み
 sudo cjk-gs-integrate-macos --link-texmf --fontdef-add=cjkgs-macos-highsierra.dat
 sudo mktexlsr
 sudo kanji-config-updmap-sys --jis2004 hiragino-highsierra-pronkpsewhich HiraginoSans-W0.ttc
