# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/fzf-alias/fzf-alias.plugin.zsh 

source ~/.zsh/sources/aliases.zsh 
source ~/.zsh/sources/funcs.zsh
source ~/.venv/bin/activate

source /opt/asdf-vm/asdf.sh

python ~/.zsh/sources/startup.py

# Load and  initialise completion system
autoload -Uz compinit
compinit

eval "$(zoxide init zsh)";
eval "$(ssh-agent -s)";

. ~/.asdf/plugins/java/set-java-home.zsh


# pnpm
export PNPM_HOME="/home/joao_linus/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

set_github
