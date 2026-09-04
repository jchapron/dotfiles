# -----------------------------
# Core environment
# -----------------------------
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"

# -----------------------------
# History
# -----------------------------
export HISTFILE="$HOME/.zhistory"
export HISTSIZE=50000
export SAVEHIST=50000
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify

# -----------------------------
# Tool settings
# -----------------------------
export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'
export FZF_DEFAULT_OPTS="\
 --height 40% --layout=reverse --border=rounded --info=inline \
 --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
 --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
 --color=selected-bg:#45475a,border:#6c7086,label:#cdd6f4"
export BAT_THEME="Catppuccin Mocha"

# -----------------------------
# PATH
# -----------------------------
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
