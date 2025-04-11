# -----------------------------
# 🧠 Git Helpers
# -----------------------------

# Quickly checkout a branch using fzf
fco() {
  git checkout "$(git branch --all | grep -v HEAD | sed 's/.* //' | fzf)"
}

# -----------------------------
# 📁 Directory Navigation
# -----------------------------

# Create and cd into directory
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Go to repo root
root() {
  cd "$(git rev-parse --show-toplevel 2>/dev/null || echo ".")"
}

# Find and cd into directory with fzf
cdf() {
  cd "$(fd --type d | fzf)"
}

# -----------------------------
# 🧙‍♂️ Dev Flow Enhancers
# -----------------------------

# Edit chezmoi dotfiles
dotedit() {
  chezmoi cd
  nvim .
}

# Start a tmux session, or attach if exists
tm() {
  tmux has-session -t main 2>/dev/null
  if [ $? != 0 ]; then
    tmux new -s main
  else
    tmux attach -t main
  fi
}

