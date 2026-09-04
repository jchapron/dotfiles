# -----------------------------
# Completion
# -----------------------------
autoload -Uz compinit
# Only rescan fpath once a day; otherwise use the cached dump.
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

zstyle ':completion:*' menu select

# Arrow keys search history by prefix
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
