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

# Fuzzy open file
fe() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-nvim} "$file"
}

# Edit files with matches
vrg() {
  rg --files-with-matches "$1" "$2" | fzf -m --preview="bat --style=numbers --theme=ansi --color=always --line-range=:100 {}" | xargs nvim
}

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

