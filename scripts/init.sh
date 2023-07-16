#!/bin/bash

set -eu

brew bundle install --file="${HOME}"/dotfiles/.Brewfile

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

killall Finder
killall Dock
