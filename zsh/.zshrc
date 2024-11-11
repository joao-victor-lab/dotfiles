# pnpm
export PNPM_HOME="/home/roboarch/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

autoload -Uz compinit 
compinit

# Keybindings
bindkey -e
bindkey '^p' atuin-up-search
bindkey '^n' atuin-up-search
bindkey '^W' kill-region

source "/usr/share/zsh/plugins/pnpm-shell-completion/pnpm-shell-completion.zsh"

FPATH+="${FPATH}:${HOME}.local/share/zsh/completions/_docker"

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

#Shell wrapper for yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

if command -v asdf; then
. /opt/asdf-vm/asdf.sh
fi

source ~/.zsh/pluggins.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/integrations.zsh

pokemon-colorscripts -r --no-title
