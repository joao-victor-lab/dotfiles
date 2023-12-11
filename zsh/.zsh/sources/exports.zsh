#!/bin/env zsh
export PATH="$HOME/.local/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/.config/zsh/utils:$PATH"

export GOBIN=`go env GOPATH`/bin 
export PATH="$PATH:$GOBIN"

export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
export PATH="$PATH:$JAVA_HOME/bin"
export SPRING_HOME="$HOME/.local/bin/spring-3.1.4"
export PATH="$SPRING_HOME/bin:$PATH"



