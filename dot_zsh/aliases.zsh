alias reload='exec zsh'
alias dots='chezmoi cd && nvim'  # Edit dotfiles quickly
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias l='ls -lah'
alias ll='ls -l'
alias la='ls -A'
alias lsd='ls -l | grep "^d"'  # List directories only
alias z='zoxide'

alias v='nvim'

alias f='fzf'
alias fo='fzf --preview "bat --style=numbers --color=always {}"'
alias ff='find . -type f | fzf'
alias fd='fd . | fzf'  # Requires `fd`

alias g='git'

alias update='brew update && brew upgrade && chezmoi update'
alias ports='lsof -i -P -n | grep LISTEN'
