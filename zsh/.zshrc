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

HISTFILE=.zsh_history
HISTSIZE=6000
SAVEHIST=6000
vim=nvim

# plug maneger zap
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "romkatv/powerlevel10k"


source $HOME/.zsh/sources/exports.zsh 
source $HOME/.zsh/sources/aliases.zsh 
source "$HOME/.zsh/sources/functions/_functions.zsh"
source /opt/asdf-vm/asdf.sh

export PATH="$HOME/.local/bin":$PATH 


# Load and  initialise completion system
autoload -Uz compinit
compinit

fpath=("/home/joaozeus/.zsh/gradle-completion" $fpath)

# pnpm
export PNPM_HOME="/home/joaozeus/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

eval "$(zoxide init zsh)";

# eval "`pip completion --bash`"


# ##lazygit 
# lg()
# {
#     export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir
#
#     lazygit "$@"
#
#     if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
#             cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
#             rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
#     fi
# }
