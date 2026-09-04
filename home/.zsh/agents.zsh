# -----------------------------
# AI coding agents: claude (Claude Code) and agent (Cursor)
# -----------------------------


# Claude Code
alias cc='claude'
alias ccc='claude --continue'                       # resume most recent session here
alias ccr='claude --resume'                         # pick a session
alias ccy='claude --permission-mode acceptEdits'    # auto-accept edits, still asks for commands
alias ccp='claude -p'                               # one-shot / pipe:  git diff | ccp "review this"
alias ccw='claude --worktree'                       # fresh git worktree for this session (add --tmux=classic for a pane)
alias ccb='claude --bg'                             # background agent; list/attach with `claude agents`
alias cca='claude agents'

# Cursor agent
alias ag='agent'
alias agr='agent resume'
alias agp='agent -p'

# claude-squad: parallel agents in tmux + worktrees (n new, N new with prompt, enter attach, C-q detach)
alias cs='claude-squad'
alias csc='claude-squad -p "agent"'                 # squad of Cursor agents

# tmux
alias ts='tmux-sessionizer'
alias ta='tmux attach || tmux new -s main'
alias tl='tmux ls'

# wt <branch> [base]: git worktree under .worktrees/ + tmux session for it.
# Then run `cc` or `ag` inside. `wt` alone lists; `wtrm <branch>` removes.
wt() {
  local root; root=$(git rev-parse --show-toplevel 2>/dev/null) || { echo "not in a git repo"; return 1; }
  if [[ $# -eq 0 ]]; then git worktree list; return; fi
  local branch=$1 base=${2:-HEAD} dir="$root/.worktrees/$1"
  if [[ ! -d "$dir" ]]; then
    git -C "$root" worktree add -b "$branch" "$dir" "$base" 2>/dev/null \
      || git -C "$root" worktree add "$dir" "$branch" || return 1
    grep -qx '.worktrees/' "$root/.git/info/exclude" 2>/dev/null || echo '.worktrees/' >> "$root/.git/info/exclude"
  fi
  tmux-sessionizer "$dir"
}
wtrm() {
  local root; root=$(git rev-parse --show-toplevel 2>/dev/null) || return 1
  [[ -n "$1" ]] || { echo "usage: wtrm <branch>"; return 1; }
  git -C "$root" worktree remove "$root/.worktrees/$1" && git -C "$root" branch -d "$1"
  tmux kill-session -t "$(basename "$root")--$(basename "$1" | tr . _)" 2>/dev/null
}

# Ghostty: alt-enter opens a plain window; inside tmux use prefix-f for the sessionizer.
