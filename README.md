# dotfiles
## how to setup
```
git clone https://github.com/nomutin/dotfiles && sh dotfiles/setup.sh
```
## change defolt terminal bash insto zsh
```
brew install zsh
sudo vim /etc/shells >> /usr/local/bin/zsh 
chsh -s /usr/local/bin/zsh
```
## how to setup tex
```
sudo tlmgr update --self --all
sudo tlmgr paper a4
sudo tlmgr install collection-langjapanese
sudo tlmgr install latexmk
```