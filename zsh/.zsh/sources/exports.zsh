#!/bin/env zsh

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.config/zsh/utils:$PATH"
export GOBIN=`go env GOPATH`/bin 
export PATH="$PATH:$GOBIN"
export SPRING_HOME="$HOME/.local/bin/spring-3.1.4"
export PATH="$SPRING_HOME/bin:$PATH"
export JAVA_HOME="$HOME/.asdf/shims/java"


