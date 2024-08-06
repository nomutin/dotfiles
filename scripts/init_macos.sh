#!/bin/bash

set -eu

# ===== Install Xcode Command Line Tools =====
if ! (xcode-select -p &>/dev/null); then
  xcode-select --install
fi

# ===== Install Homebrew =====
if ! (type 'brew' >/dev/null 2>&1); then
  xcode-select --install
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# ===== Install apps =====
brew bundle install --file="${HOME}"/.dotfiles/config/Brewfile

# ===== Mac settings =====
# Terminal display name
sudo scutil --set HostName MBA

# Fasten
defaults write -g com.apple.trackpad.scaling 3
defaults write -g com.apple.mouse.scaling 1.5
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10

# Click to tap
defaults write -g com.apple.mouse.tapBehavior -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Dock
defaults write com.apple.dock autohide-time-modifier -int 0
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 128

# Disable .DS_Store creation
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Finder
defaults write com.apple.finder NewWindowTarget -string PfHm
defaults write com.apple.finder NewWindowTargetPath -string "file:///Users/nomura/"
defaults write com.apple.finder ShowRecentTags -int 0
defaults write com.apple.finder ShowMountedServersOnDesktop -int 0
defaults write com.apple.finder SidebarTagsSctionDisclosedState -int 1
defaults write com.apple.finder PreferencesWindow.LastSelection -string SDBR
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool YES && killall Finder

# TextEdit
defaults write com.apple.TextEdit RichText -int 0

# Screenshot
defaults write com.apple.screencapture type jpg

killall Finder
killall Dock
sudo shutdown -r now
