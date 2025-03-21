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
bindkey -v

# bindkey -x '"\C-r": __atuin_history'

bindkey '^p' atuin-up-search
bindkey '^n' atuin-up-search
bindkey '^W' kill-region

export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"

export TODO_DIR=/data/robot/nots/BigBrain/06_Daily/tasks/
