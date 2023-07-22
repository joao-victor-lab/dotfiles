#!/bin/sh

alias zreload="source ~/.zshrc"

alias bcat="bat --style=auto"

alias ls="exa --icons"
alias la="exa -a --icons"
alias ll="exa -la --icons"

alias tree="dust"

alias ../="z ../ "

alias ecommit="git commit"
alias commit="git commit -m"
alias gdd="git add"
alias gddl="git add ."
alias giadd="git add -i"
alias glog="git log"
alias gstatus="git  status"

alias mirror="sudo reflector -f 30 -l 30 --number 20 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 30 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 30 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 30 --sort age --save /etc/pacman.d/mirrorlist"

alias cp="cp -i"
alias mv"mv -i"
alias rm="rm -i"

alias fish="asciiquarium"
