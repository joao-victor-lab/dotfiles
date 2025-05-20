# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load Personal Stuff
bindkey -v

. ~/.zsh/aliases.zsh


# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
#zinit snippet OMZP::git
#zinit snippet OMZP::sudo
#zinit snippet OMZP::archlinux
#zinit snippet OMZP::aws
#zinit snippet OMZP::kubectl
#zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

zinit load thirteen37/fzf-alias
enable-fzf-tab

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Completion styling
#
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle -d ':completion:*' format
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# for zoxide completion
zstyle ':fzf-tab:complete:__zoxide_cd:*' fzf-preview 'eza -1 --color=always $realpath'
# git completion
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'

# no prview for options
  zstyle ':fzf-tab:complete:*:options' fzf-preview ''
  # preview for files
  zstyle ":fzf-tab:complete:*:argument-rest" fzf-preview '
    if [[ -d "$realpath" ]]; then
      tree -C -L 3 "$realpath"
    elif [[ -f "$realpath" ]]; then
      if $(grep -qI . "$realpath"); then
        bat -p --color=always "$realpath"
      else
        echo "Realpath: $realpath"
        # Use gstat for Linux; fallback to stat for macOS or BSD
        local stat_cmd
        local -a stat_opts
        local arch=$(uname -s)
        if [[ $OSTYPE = darwin* ]]; then
          # Darwin / FreeBSD version
          local gprefix
          command -v gstat &>/dev/null && gprefix=g
          echo "Yes"
          if [[ -z $gprefix ]]; then
              stat_cmd="stat"
              stat_opts=(
              "-f"
              "File: %N\nLocation: %d:%i\nMode: %Sp (%Mp%Lp)\nLinks: %l\nOwner: %Su/%Sg\nSize: %z (%b blocks)\nChanged: %Sc\nModified: %Sm\nAccessed: %Sa"
              )
          fi
        else
          # Linux or Darwin with GNU support
          stat_cmd="${gprefix}stat"
          stat_opts=(
            "-c"
            "File: %N\nType: %F\nLocation: %d:%i\nMode: %A (%a)\nLinks: %h\nOwner: %U/%G\nSize: %s (%b blocks)\nChanged: %z\nModified: %y\nAccessed: %x"
          )
        fi

        echo $($stat_cmd "$stat_opts[@]" "$realpath")
      fi
    fi'


# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"

# Load completions
autoload -Uz compinit && compinit
