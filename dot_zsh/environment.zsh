# -----------------------------
# 🧭 Core Environment Settings
# -----------------------------

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"
export HISTFILE=$HOME/.zhistory
export SAVEHIST=1000
export HISTSIZE=999

# -----------------------------
# 🧪 Setup
# -----------------------------

eval "$(starship init zsh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(zoxide init zsh)"
eval "$(sheldon source)"

# -----------------------------
# 🤖 Tools
# -----------------------------
export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'

# -----------------------------
# 💻 Path Hygiene
# -----------------------------

# Ensure ~/.local/bin and ~/bin are included
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
