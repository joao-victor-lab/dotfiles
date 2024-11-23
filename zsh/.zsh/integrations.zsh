#!/usr/bin/env zsh

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(batman --export-env)"
eval "$(thefuck --alias zsh)"
# eval "$(tldr --print-completions zsh)"

. /usr/share/wikiman/widgets/widget.zsh

