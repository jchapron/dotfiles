alias reload='exec zsh'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias l='ls -lah'
alias ll='ls -l'
alias la='ls -A'
alias ldir='ls -l | grep "^d"'  # List directories only

alias v='nvim'

alias f='fzf'
alias fo='fzf --preview "bat --style=numbers --color=always {}"'
alias ff='find . -type f | fzf'
alias ffd='fd . | fzf'

alias g='git'

alias update='brew update && brew upgrade'
alias bubu='brew bundle --file ~/Brewfile'
alias ports='lsof -i -P -n | grep LISTEN'

alias cursor='open -a "Cursor"'
