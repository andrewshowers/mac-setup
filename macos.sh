#!/bin/zsh
# macOS settings. Safe to re-run. Keyboard settings apply after you log out and back in.
set -euo pipefail

# Show all file extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Finder: show the path bar and status bar
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
# Fast key repeat (2 = 30 ms) and a short delay before it starts (15 = 225 ms)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Holding a key repeats it instead of opening the accent picker
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Save screenshots to ~/Pictures/Screenshots
mkdir -p ~/Pictures/Screenshots
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"
# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true
# Natural scrolling (trackpad); mice are flipped back by Karabiner
defaults write -g com.apple.swipescrolldirection -bool true
# Touch ID for sudo
[[ -f /etc/pam.d/sudo_local ]] || sed 's/^#auth/auth/' /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local >/dev/null
# Don't write .DS_Store files to network shares
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

killall Finder Dock SystemUIServer
