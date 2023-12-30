#!/bin/bash

set -eu

brew bundle install --file="${HOME}"/.dotfiles/Brewfile

# terminalの表示名を`MBA`に変更
sudo scutil --set HostName MBA

# 動きを高速化
defaults write -g com.apple.trackpad.scaling 3
defaults write -g com.apple.mouse.scaling 1.5
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10

# タップしたときクリック
defaults write -g com.apple.mouse.tapBehavior -int 1

# クラッシュレポートを無効化する
defaults write com.apple.CrashReporter DialogType -string "none"

# 未確認のアプリケーションを実行する際のダイアログを無効にする
defaults write com.apple.LaunchServices LSQuarantine -bool false

# ダウンロードしたファイルを開くときの警告ダイアログをなくす
defaults write com.apple.LaunchServices LSQuarantine -bool false

# ゴミ箱を空にする前の警告の無効化
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Dock関連
defaults write com.apple.dock autohide-time-modifier -int 0
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 128

# ネットワークストアファイルを作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Bluetoothのマルチタッチトラックパッドでクリックを有効化
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Finder関連
defaults write com.apple.finder NewWindowTarget -string PfHm
defaults write com.apple.finder NewWindowTargetPath -string "file:///Users/nomura/"
defaults write com.apple.finder ShowRecentTags -int 0
defaults write com.apple.finder ShowMountedServersOnDesktop -int 0
defaults write com.apple.finder SidebarTagsSctionDisclosedState -int 1
defaults write com.apple.finder PreferencesWindow.LastSelection -string SDBR

# テキストエディットをプレーンテキストで使う
defaults write com.apple.TextEdit RichText -int 0

# 隠しファイルを常にファインダーに表示する
defaults write com.apple.finder AppleShowAllFiles -bool YES && killall Finder

# スクリーンショットをjpgで保存
defaults write com.apple.screencapture type jpg

# 全ての拡張子のファイルを表示する
defaults write -g AppleShowAllExtensions -bool true

# .DS_Storeを作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

killall Finder
killall Dock
sudo shutdown -r now
