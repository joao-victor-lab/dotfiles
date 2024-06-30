# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt auto_cd
setopt No_Beep

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# History
export HISTSIZE=8000
export HISTFILE=~/.zsh_history
export SAVEHIST=$HISTSIZE
export HISTDUP=erase
export BROWSER="librewolf"
export EDITOR="nvim"
export TERM="kitty"
export TERMINAL="kitty"

export GOPATH="${HOME}/.go"
export GOBIN="$(go env GOPATH)/bin"
export PATH=$GOBIN:${PATH}
