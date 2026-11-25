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
# Touch ID for sudo
[[ -f /etc/pam.d/sudo_local ]] || sed 's/^#auth/auth/' /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local >/dev/null

killall Finder Dock SystemUIServer
