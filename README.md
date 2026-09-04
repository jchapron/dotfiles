# dotfiles

macOS setup for a keyboard-first, minimal workflow. Catppuccin Mocha everywhere.

| Area | Where |
|---|---|
| Shell | `home/.zshrc`, `home/.zsh/*.zsh` (zsh, sheldon plugins, starship prompt) |
| Terminal | `home/.config/ghostty`, `home/.config/tmux` + `home/.local/bin/tmux-sessionizer` |
| Editor | `home/.config/nvim` (kickstart.nvim base, ThePrimeagen layer in `lua/custom`) |
| Git | `home/.gitconfig`, `home/.config/git`, delta theme in `home/.config/delta` |
| Window manager | `home/.aerospace.toml` (AeroSpace + JankyBorders) |
| Toolchains | `home/.config/mise/config.toml` (node, python, uv, pnpm, typescript) |
| AI agents | `home/.claude`, `home/.claude-squad`, `home/.zsh/agents.zsh` |
| macOS | `home/.config/macos/defaults.sh` (preferences, Dock, menu bar), `sudo-once.sh` |
| Packages | `home/Brewfile` |

## Install

```sh
git clone git@github.com:jchapron/dotfiles.git ~/dotfiles && ~/dotfiles/install.sh
```

`install.sh` is idempotent: Homebrew, `stow` symlinks from `home/` into `~`, `brew bundle`, mise, sheldon, Neovim plugins, macOS defaults.

## Layout

`home/` mirrors `$HOME`. Every file in it is symlinked into place with GNU stow, so editing `~/.zshrc` edits the repo. Machine-local extras go in `~/.zsh/local.zsh` and `~/.zsh/ssh.zsh`, which are git-ignored.
