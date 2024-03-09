#!/bin/env zsh

alias ls="eza -1 --icons" #short list
alias  l='eza -lh  --icons=auto' # long list
alias la="eza -1a --icons" #show short hidden
alias lh="eza -lha --icons" 
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs

# alias ecommit="git commit"
alias commit="git commit -m"
alias gs="git s"
alias gadd="git add ."
alias gad="git add -i"
alias glog="git log"

alias mirror="sudo reflector -f 30 -l 30 --number 40 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 40 --sort delay --verbose --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 40 --sort score --verbose --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 40 --sort age --verbose --save /etc/pacman.d/mirrorlist"

alias cp="cp -i"
alias mv"mv -i"
alias rm="rm -i"
alias mkdir="mkdir -pv"

alias fish="asciiquarium"

alias hd="hexdump"

alias stow="stow --verbose"

alias !!="fc -ln -1"

# Detect the AUR wrapper
if pacman -Qi yay &>/dev/null ; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null ; then
   aurhelper="paru"
fi

function in {
    local pkg="$1"
    if pacman -Si "$pkg" &>/dev/null ; then
        sudo pacman -S "$pkg"
    else
        "$aurhelper" -S "$pkg"
    fi
}

# Helpful aliases
alias un='$aurhelper -Rns' # uninstall package
alias up='$aurhelper -Syu' # update system/package/aur
alias pl='$aurhelper -Qs' # list installed package
alias pa='$aurhelper -Ss' # list availabe package
alias pc='$aurhelper -Sc' # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -

alias vc='code --ozone-platform-hint=wayland --disable-gpu' # gui code editor

# Handy change dir shortcuts
alias ..='z ..'
alias ...='z ../..'
alias .3='z ../../..'
alias .4='z ../../../..'
alias .5='z ../../../../..'

# Fixes "Error opening terminal: xterm-kitty" when using the default kitty term to open some programs through ssh
alias ssh='kitten ssh'
