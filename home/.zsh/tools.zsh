# -----------------------------
# Tool initialisation
# -----------------------------
# brew first: it puts /opt/homebrew/bin on PATH for everything below.
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

command -v mise    >/dev/null && eval "$(mise activate zsh)"
command -v zoxide  >/dev/null && eval "$(zoxide init zsh)"
command -v sheldon >/dev/null && eval "$(sheldon source)"
command -v starship >/dev/null && eval "$(starship init zsh)"
