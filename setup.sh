#!/bin/bash

#"===== brew install ====="
xcode-select --install

if !(type 'brew' > /dev/null 2>&1); then
    xcode-select --install
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi	

#"===== make dotfiles alias ====="
DOT_FILES=(.gitconfig .zshrc .gitignore .vimrc .vim .latexmkrc)
for file in ${DOT_FILES[@]};
do
    ln -sf $HOME/dotfiles/$file $HOME/$file
done

#"===== startup apps =====
brew install --cask iterm2 deepl coteditor visual-studio-code keyboardcleantool dozer mathpix-snipping-tool google-drive zoom arc raycast slack discord qlmarkdown

#"===== MacBook settings =====
sudo scutil --set HostName MBA
defaults write com.apple.dock autohide-time-modifier -int 0 
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 100

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write -g com.apple.trackpad.scaling 3
defaults write -g com.apple.trackpad.tapBehavior -int 1

defaults write com.apple.finder NewWindowTarget -string PfHm
defaults write com.apple.finder NewWindowTargetPath -string "file:///Users/nomura/"
defaults write com.apple.finder ShowRecentTags -int 0
defaults write com.apple.finder ShowMountedServersOnDesktop -int 0
defaults write com.apple.finder SidebarTagsSctionDisclosedState -int 1
defaults write com.apple.finder PreferencesWindow.LastSelection -string SDBR

open /Applications/DeepL.app
open /Applications/Raycast.app
open /Applications/"Visual Studio Code.app"
open /Applications/KeyboardCleanTool.app
open /Applications/"Mathpix Snipping Tool.app"
open /Applications/"Google Drive.app"
open /Applications/Discord.app
open /Applications/Slack.app
open /Applications/zoom.us.app
open /Applications/arc.app

killall Finder
killall Dock