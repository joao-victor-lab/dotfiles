#!/bin/sh

export TERM=alacritty

export PATH="$HOME/.local/bin":$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH="$PATH:$HOME/.config/lvim/lua/joao/scripts"

export GOBIN=`go env GOPATH`/bin 
export PATH=$PATH:$GOBIN
