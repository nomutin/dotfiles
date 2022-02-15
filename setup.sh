#!/bin/bash

#"===== brew install ====="
xcode-select --install

if !(type 'brew' > /dev/null 2>&1); then
    xcode-select --install
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi	

#"===== make dotfiles alias ====="
DOT_FILES=(.gitconfig .zshrc .gitignore .vimrc .vim .latexmkrc .zshenv)
for file in ${DOT_FILES[@]};
do
    ln -sf $HOME/dotfiles/$file $HOME/$file
done
 
#"===== startup apps =====
brew install --cask iterm2 clipy deepl coteditor alfred swiftdefaultappsprefpane visual-studio-code rectangle keyboardcleantool dozer mathpix-snipping-tool google-drive slack zoom

#"===== MacBook settings =====
defaults write com.apple.dock autohide-time-modifier -int 0 
defaults write com.apple.dock autohide -bool true
defaults write -g com.apple.trackpad.scaling 3
defaults write -g com.apple.trackpad.tapBehavior -int 1
brew install blacktop/tap/lporg
# open /Applications/Clipy.app
# open /Applications/DeepL.app
# open /Applications/CotEditor.app
# open /Applications/"Alfred 4.app"
# open /Applications/"Visual Studio Code.app"
# open /Applications/Rectangle.app
# open /Applications/KeyboardCleanTool.app
# open /Applications/"Mathpix Snipping Tool.app"
# open /Applications/"Google Drive.app"
# open /Applications/Slack.app
# open /Applications/zoom.us.appss
killall Finder
killall Dock
# sudo reboot