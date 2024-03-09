export HISTFILE=~/.zsh_history
export HISTSIZE=6000
export SAVEHIST=6000
export EDITOR=nvim

export GOBIN=`go env GOPATH`/bin
export PATH=$GOBIN:${PATH}

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
