# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.

# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zprofile

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# pnpm
export PNPM_HOME="/home/roboarch/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q
zi cdlist &> /dev/null # look at gathered compdefs

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light MichaelAquilina/zsh-you-should-use
zinit load atuinsh/atuin
# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet "https://gist.githubusercontent.com/joao-victor-lab/778ed025ad4b01919c1b62542a9397c5/raw/"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' atuin-up-search
bindkey '^n' atuin-up-search
bindkey '^[w' kill-region

source "/usr/share/zsh/plugins/pnpm-shell-completion/pnpm-shell-completion.zsh"

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(batman --export-env)"
eval $(thefuck --alias zsh)

#Shell wrapper for yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

. /opt/asdf-vm/asdf.sh


# fzf-man-widget() {
#   batman="man {1} | col -bx | bat --language=man --plain --color always --theme=\"Monokai Extended\""
#    man -k . | sort \
#    | awk -v cyan=$(tput setaf 6) -v blue=$(tput setaf 4) -v res=$(tput sgr0) -v bld=$(tput bold) '{ $1=cyan bld $1; $2=res blue;} 1' \
#    | fzf  \
#       -q "$1" \
#       --ansi \
#       --tiebreak=begin \
#       --prompt=' Man > '  \
#       --preview-window '50%,rounded,<50(up,85%,border-bottom)' \
#       --preview "${batman}" \
#       --bind "enter:execute(man {1})" \
#       --bind "alt-c:+change-preview(cht.sh {1})+change-prompt(ﯽ Cheat > )" \
#       --bind "alt-m:+change-preview(${batman})+change-prompt( Man > )" \
#       --bind "alt-t:+change-preview(tldr --color=always {1})+change-prompt(ﳁ TLDR > )"
#   zle reset-prompt
# }
#
# # `Ctrl-H` keybinding to launch the widget (this widget works only on zsh, don't know how to do it on bash and fish (additionaly pressing`ctrl-backspace` will trigger the widget to be executed too because both share the same keycode)
# bindkey '^h' fzf-man-widget
# zle -N fzf-man-widget

# yay -S todotxt-git 
alias td=todo.sh
autoload _todo todo

pokemon-colorscripts -r --no-title

eval $(thefuck --alias)
