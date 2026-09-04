#!/usr/bin/env bash
# Bootstrap a Mac from this repo. Idempotent; re-run any time.
#   git clone git@github.com:jchapron/dotfiles.git ~/dotfiles && ~/dotfiles/install.sh
set -euo pipefail
cd "$(dirname "$0")"

step() { printf '\n\033[1;35m==> %s\033[0m\n' "$*"; }

step "Xcode command line tools"
xcode-select -p >/dev/null 2>&1 || xcode-select --install

step "Homebrew"
if ! command -v brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

step "Symlinks (stow)"
brew list stow >/dev/null 2>&1 || brew install stow
# stow refuses to overwrite real files; move any in the way aside once
for f in .zshrc .gitconfig .aerospace.toml Brewfile .config/starship.toml .claude/settings.json .claude/CLAUDE.md; do
  [[ -e "$HOME/$f" && ! -L "$HOME/$f" ]] && mv "$HOME/$f" "$HOME/$f.pre-dotfiles"
done
stow --restow --target="$HOME" --dir="$PWD" home

step "Homebrew bundle"
brew bundle --file="$HOME/Brewfile" --no-upgrade

step "Toolchains (mise)"
mise trust "$HOME/.config/mise/config.toml" >/dev/null 2>&1 || true
mise install --yes

step "zsh plugins (sheldon)"
sheldon lock --update >/dev/null

step "Cursor agent CLI"
command -v agent >/dev/null || curl -fsS https://cursor.com/install | bash

step "Neovim plugins, parsers, language servers"
nvim --headless +qa >/dev/null 2>&1 || true
nvim --headless "+MasonToolsInstallSync" +qa >/dev/null 2>&1 || true

step "macOS defaults"
bash "$HOME/.config/macos/defaults.sh"

cat <<'MSG'

Done. Manual steps:
  - Grant Accessibility to AeroSpace and Hidden Bar when prompted; drag stray icons behind Hidden Bar.
  - gh auth login · agent login · add ~/.ssh/id_ed25519.pub as a signing key on GitHub
  - sudo bash ~/.config/macos/sudo-once.sh   (Touch ID for sudo, Nix cleanup)
  - Log out and back in for keyboard/trackpad settings.
MSG
