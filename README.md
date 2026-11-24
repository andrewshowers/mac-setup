# mac-setup

My Mac as a repo: what Homebrew installs, a few dotfiles, and the macOS settings I always change. One script applies all of it and is safe to re-run.

## What's here

- `Brewfile`: CLI tools, apps and VS Code extensions.
- `config/`: dotfiles that `setup.sh` symlinks into place:
  - `zshrc` → `~/.zshrc`
  - `gitconfig` → `~/.gitconfig`
  - `ghostty/` → `~/.config/ghostty`
  - `karabiner/` → `~/.config/karabiner` (Karabiner writes `karabiner.json` here on first launch)
- `setup.sh`: links `config/`, runs `brew bundle`, then runs `macos.sh`.
- `macos.sh`: Finder, keyboard, screenshot and Dock settings.
- `HOMEBREW-GUIDE.md`: Brewfile conventions and the everyday Homebrew workflow.

## Fresh Mac

1. Install the Command Line Tools:
   ```zsh
   xcode-select --install
   ```
2. Install Homebrew from https://brew.sh. Run the "Next steps" commands it prints; they add `brew` to your PATH in `~/.zprofile`.
3. Install the GitHub CLI and sign in:
   ```zsh
   brew install gh
   gh auth login
   ```
4. Clone this repo:
   ```zsh
   gh repo clone andrewshowers/mac-setup ~/code/mac-setup
   cd ~/code/mac-setup
   ```
5. Apply everything:
   ```zsh
   ./setup.sh
   ```
6. Log out and back in so the keyboard settings take effect.

`setup.sh` replaces existing files at the link targets (for example a `~/.zshrc`). If a target is a real directory, such as `~/.config/karabiner` after Karabiner has already run, it stops and tells you. Move that directory aside and re-run.

## Edit the repo first, then apply

The repo is the source of truth. Don't change settings in place. Change the file here, then apply it:

| Changed | Apply with |
|---|---|
| `Brewfile` | `brew bundle --file Brewfile` |
| `config/*` | Nothing to run: it's already linked. Open a new shell or reload Ghostty. |
| `macos.sh` | `./macos.sh` |
| New dotfile | Add it to `config/` and a `link` line to `setup.sh`, then `./setup.sh` |

Changes you make in Karabiner's settings land in `config/karabiner/karabiner.json` through the symlink. Commit them.
