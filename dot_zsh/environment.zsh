# -----------------------------
# 🧭 Core Environment Settings
# -----------------------------

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"

# -----------------------------
# 🧪 Homebrew Setup
# -----------------------------

eval "$(/opt/homebrew/bin/brew shellenv)"

# -----------------------------
# 💻 Path Hygiene
# -----------------------------

# Ensure ~/.local/bin and ~/bin are included
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
