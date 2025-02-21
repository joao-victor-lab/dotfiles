#!/usr/bin/env zsh

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
 # eval "$(batman --export-env)"
 # eval "$(thefuck --alias zsh)"
# eval "$(tldr --print-completions zsh)"

WIKIMAN_WIDGET="/usr/share/wikiman/widgets/widget.zsh"
[[ ! -f $WIKIMAN_WIDGET ]] || source $WIKIMAN_WIDGET

if [[ -x "$(which asdf)" ]]; then
  export ASDF_DATA_DIR="$HOME/.local/share/asdf"
  export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
  fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
fi

