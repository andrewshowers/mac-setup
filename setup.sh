#!/bin/zsh
# Link config/ into place, install Homebrew packages, apply macOS settings. Safe to re-run.
set -euo pipefail

repo="${0:A:h}"
cd "$repo"

# link NAME TARGET: make TARGET a symlink to config/NAME
link() {
  local src="$repo/config/$1" dst="$2"
  if [[ -d "$dst" && ! -L "$dst" ]]; then
    print -u2 "Stopped: $dst is a real directory. Move it aside, then re-run ./setup.sh"
    exit 1
  fi
  mkdir -p "${dst:h}"
  ln -sfn "$src" "$dst"
  print "linked $dst -> $src"
}

# Links first, so installers (e.g. Karabiner) can't create these as real directories
link zshrc     ~/.zshrc
link gitconfig ~/.gitconfig
link ghostty   ~/.config/ghostty
link karabiner ~/.config/karabiner

brew bundle --file Brewfile

"$repo/macos.sh"
