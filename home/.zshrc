# ~/.zshrc
export ZSH_CONFIG_DIR="$HOME/.zsh"

# Load order matters: environment/tools set PATH before anything else runs.
for name in environment tools aliases functions ssh agents completion; do
  [[ -r "$ZSH_CONFIG_DIR/$name.zsh" ]] && source "$ZSH_CONFIG_DIR/$name.zsh"
done
unset name
