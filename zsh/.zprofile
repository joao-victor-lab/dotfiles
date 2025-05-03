HISTSIZE=0 # I use atuin btw
HISTFILE="~/.zsh_history"
SAVEHIST="$HISTSIZE"
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Keybindings

# bindkey -x '"\C-r": __atuin_history'

bindkey '^p' atuin-up-search
bindkey '^n' atuin-up-search
bindkey '^[w' kill-region

export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"
#export TODO_DIR="/home/robot/Documents/var/tasks"

export ASDF_CONFIG_FILE="${HOME}/.config/asdf/config"
export ASDF_DATA_DIR="$HOME/.local/share/asdf"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf $fpath)

# pnpm
export PNPM_HOME="/home/robot/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


