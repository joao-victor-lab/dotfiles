typeset -U path PATH
path=(~/.local/bin $path)
path=(~/.cargo/bin/ $path)
path=( ~/.asdf/bin $path)
export PATH

source ~/.zsh/aliases.zsh
source ~/.zsh/integrations.zsh
