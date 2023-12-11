# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

HISTFILE="/home/joaozeus/.zsh/history/"
HISTSIZE=6000
SAVEHIST=6000


# plug maneger zap
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "romkatv/powerlevel10k"


source $HOME/.zsh/sources/exports.zsh 
source $HOME/.zsh/sources/sources.zsh 
source $HOME/.zsh/sources/aliases.zsh 
source $HOME/.zsh/sources/my_functions.zsh

export PATH="$HOME/.local/bin":$PATH 


# Load and  initialise completion system
autoload -Uz compinit
compinit

fpath=(/home/joaozeus/.zsh/gradle-completion $fpath)

# pnpm
export PNPM_HOME="/home/joaozeus/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

eval "$(zoxide init zsh)";
