#!/usr/bin/env zsh

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone --depth 1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

# zinit ice atinit'zmodload zsh/zprof' \
#     atload'zprof | head -n 20; zmodload -u zsh/zprof'

# zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice depth"1"
zinit light zsh-users/zsh-completions
# zinit light zsh-users/zsh-autosuggestions
zinit ice depth"1"
zinit light Aloxaf/fzf-tab
zinit ice depth"1"
zinit light MichaelAquilina/zsh-you-should-use
zinit ice depth"1"
zinit light NullSense/fuzzy-sys
zinit ice depth"1"
zinit load atuinsh/atuin
# zinit light kazhala/dotbare
zinit light Freed-Wu/fzf-tab-source

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' \
    atpull'%atclone' pick"direnv" src"zhook.zsh" for \
        direnv/direnv

# Add in snippets
# zinit snippet OMZP::git
# zinit snippet OMZP::sudo
# zinit snippet OMZP::archlinux
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
# zinit snippet OMZP::command-not-found
# zinit snippet OMZP::asdf

zinit creinstall ~/.local/share/zsh/completions/ >> /dev/null

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
