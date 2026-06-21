# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
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

cleanup() {
    bash ~/Repositories/manjaro-cleanup-script/clean-up-manjaro.sh
}

update-dotfiles() {
    bash ~/Repositories/dotfiles/update.sh && \
    cd ~/Repositories/dotfiles && \
    git add -A && \
    if ! git diff --cached --quiet; then
        git commit -m "update dotfiles" && git push
    else
        echo "Dotfiles already up to date, nothing to commit."
    fi && \
    cd - > /dev/null
}

neovim-plugin-update() {
    local pack_dir="$HOME/.local/share/nvim/site/pack"
    local lock_file="$HOME/.config/nvim/nvim-pack-lock.json"
    local updated=0

    echo "Atualizando plugins Neovim...\n"

    for dir in "$pack_dir"/*/opt/*/; do
        if [[ -d "$dir/.git" ]]; then
            local plugin=$(basename "$dir")
            local current=$(git -C "$dir" rev-parse HEAD 2>/dev/null)

            git -C "$dir" fetch origin --quiet 2>/dev/null
            local remote_head=$(git -C "$dir" rev-parse FETCH_HEAD 2>/dev/null)

            if [[ "$remote_head" == "$current" ]]; then
                echo "  = $plugin"
            else
                git -C "$dir" reset --hard FETCH_HEAD --quiet 2>/dev/null
                local new=$(git -C "$dir" rev-parse HEAD)
                echo "  ↑ $plugin  ${current:0:7} → ${new:0:7}"
                updated=$((updated + 1))

                if [[ -f "$lock_file" ]]; then
                    sed -i "/$plugin/{n;s/\"rev\": \"[^\"]*\"/\"rev\": \"$new\"/}" "$lock_file"
                fi
            fi
        fi
    done

    echo "\nConcluído! $updated plugin(s) atualizado(s)."
}

my-commands() {
    echo "Comandos pessoais (~/.zshrc):\n"
    grep -E '^\s*[a-zA-Z_][a-zA-Z0-9_-]*\s*\(\)' ~/.zshrc \
        | grep -v '^_' \
        | sed 's/().*//' \
        | sed 's/^[[:space:]]*/    /'
}
