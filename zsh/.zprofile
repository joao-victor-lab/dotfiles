export HISTFILE=~/.zsh_history
export HISTSIZE=6000
export SAVEHIST=6000
export EDITOR=`which nvim`

export CARGO_BIN=$HOME/.cargo/bin
export GOBIN=`go env GOPATH`/bin
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
export PATH=$HOME/.local/bin:$CARGO_BIN:$GOBIN:${PATH}
