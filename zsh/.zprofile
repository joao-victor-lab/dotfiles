HISTSIZE=0 # I use atuin btw
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

export EDITOR="nvim"
export VISUAL="nvim"

# export MANPAGER="sh -c '$batman'"
# for better MANPAGER use batman script for highligh  https://github.com/eth-p/bat-extras
