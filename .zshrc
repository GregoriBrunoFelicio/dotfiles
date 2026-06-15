# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

function _set_tab_title() {
  local git_root
  git_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ -n "$git_root" ]]; then
    print -Pn "\e]2;$(basename "$git_root")\a"
  else
    print -Pn "\e]2;$(basename "$PWD")\a"
  fi
}
precmd_functions+=(_set_tab_title)
chpwd_functions+=(_set_tab_title)

export PATH="$HOME/.dotnet/tools:$PATH"

repo() {
    cd ~/Repositories
}
