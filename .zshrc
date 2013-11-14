# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set powerline shell
function powerline_precmd() {
  export PS1="$(~/powerline-shell.py $? --shell zsh --cwd-max-depth 3)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

install_powerline_precmd

# Plugins to load
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Use different files to keep zshrc readable
for file in ~/.{exports,aliases,sshaliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

# Customize to your needs...
# export PATH=$PATH:/Users/jchapron/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export TERM="xterm-256color"
export PATH=$PATH:/usr/local/opt/coreutils/libexec/gnubin
# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

umask 0002
