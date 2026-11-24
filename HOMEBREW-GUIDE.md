# Managing a Mac's software with Homebrew

Keep everything you install in one text file, the `Brewfile`, in a git repo. A new machine then needs one command to match the old one.

## Setup

```zsh
# Install Homebrew first (see brew.sh), then:
brew bundle --file Brewfile                # install everything listed
brew bundle check --file Brewfile          # report anything missing, installs nothing
brew bundle dump --file Brewfile --force   # generate a Brewfile from what's installed now
```

`brew bundle dump` is the quickest way to inventory an existing machine. Run it, then trim the file to what you actually want.

## Example Brewfile

An excerpt. The full file is `Brewfile` in this repo.

```ruby
# --- Command-line tools
brew "git"
brew "gh"
brew "fzf"

# --- Apps: now
cask "ghostty"
cask "visual-studio-code"

# --- Apps: later (uncomment, then re-run brew bundle)
# cask "obsidian"
# brew "ripgrep"
# mas "Xcode", id: 497799835

# --- VS Code extensions
vscode "bierner.markdown-mermaid"
```

- `brew` lines are command-line tools.
- `cask` lines are GUI apps and larger installers.
- `vscode` lines are VS Code extensions. They need `code` on your PATH, which the VS Code cask provides.
- `mas` lines are Mac App Store apps. They need `brew "mas"` and you must be signed in to the App Store.
- `tap` lines add third-party repositories. Taps can require trusting the formula once per Mac (`brew trust`).

## Conventions

- **One line per item, grouped by purpose, with section headers.** Put comments on their own lines, not trailing, so the file stays easy to parse.
- **Keep a "later" section of commented-out entries.** Uncomment an entry and re-run `brew bundle` to install it.
- **Explain what you deliberately don't install with Homebrew.** Add a comment saying why and what you do instead. Examples:
  - `android-platform-tools`: a second `adb` conflicts with the one in the Android SDK.
  - Any cask that ships a newer major version than your team supports: install the supported one by hand.
- **Pin a version only when you need to.** Use versioned formulas or casks such as `node@22`.
- **Edit the Brewfile first, then apply it,** so the file stays the source of truth.

## Everyday workflow

```zsh
brew bundle --file Brewfile              # after editing the Brewfile
brew update && brew upgrade              # update installed software
brew bundle cleanup --file Brewfile      # list installed items not in the Brewfile (--force removes them)
```

## What Homebrew doesn't cover

Use Homebrew for installs and a script for configuration. In this repo, `setup.sh` symlinks the dotfiles in `config/` into place and `macos.sh` applies system settings. Keep both safe to re-run.

Keep secrets out of the repo. Put them in a git-ignored, permission-600 env file that your shell loads.

## Moving from an old machine

1. Run `brew bundle dump` (or list apps by hand) to inventory what you use.
2. Before retiring the old machine, check every repo for uncommitted changes, unpushed commits, stashes, and git-ignored config files.
3. Regenerate secrets and tokens on the new machine rather than copying them.
4. Keep a short "not ported" list so you know what was left behind on purpose.
