if zoxide --version &>/dev/null ; then
   cd_cmd='z' # eval "$(zoxide init zsh)" in ~/.zshrc
else
   cd_cmd='cd'
fi

alias v='nvim'
alias vim='nvim'

alias pn="pnpm"
alias zi="zi"

alias in='yay -Slq | fzf --multi --preview "yay -Si {1}" | xargs -ro yay -Sy'
alias dl='yay -Qq | fzf --multi --preview "yay -Qi {1}" | xargs -ro yay -Rns'
alias up='yay -Syu' # update system/package/aur
alias pl='yay -Qs | fzf' # list installed package
alias pc='yay -Sc' # remove unused cache
alias po='yay -Qtdq | yay -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -


alias  c='clear' # clear terminal
alias  l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias la='eza -a --icons=auto'
alias lla='eza -lha --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree
alias cat='bat --color=always'

alias mkdir='mkdir --parents --verbose'
alias cp='cp --verbose --interactive'
alias rm='rm --interactive=always --verbose'
alias rmd='rm --interactive=once --verbose --recursive --force'

alias ..='$cd_cmd ..'
alias ...='$cd_cmd ../..'
alias .3='$cd_cmd ../../..'
alias .4='$cd_cmd ../../../..'
alias .5='$cd_cmd ../../../../..'
alias path='echo -e ${PATH//:/\\n}'

alias ports='netstat -tulanp'

alias root='sudo -i'
alias su='sudo -i'

alias zrel="exec zsh"

# fd - cd to selected directory
cf() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# cf - fuzzy cd from anywhere
# ex: cf word1 word2 ... (even part of a file name)
# zsh autoload function
cf() {
  local file

  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file
     else
        cd -- ${file:h}
     fi
  fi
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  IFS=$'\n' files=($( fzf --query="$1" --multi --select-1 --exit-0 ))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  IFS=$'\n' out=("$(fzf --preview="bat --color=always {}" --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# Install one or more versions of specified language
# e.g. `vmi rust` # => fzf multimode, tab to mark, enter to install
# if no plugin is supplied (e.g. `vmi<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [I]nstall
vmi() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions=$(asdf list-all $lang | fzf --tac --no-sort --multi)
    if [[ $versions ]]; then
      for version in $(echo $versions);
      do; asdf install $lang $version; done;
    fi
  fi
}

# Remove one or more versions of specified language
# e.g. `vmi rust` # => fzf multimode, tab to mark, enter to remove
# if no plugin is supplied (e.g. `vmi<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [C]lean
vmc() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions=$(asdf list $lang | fzf -m)
    if [[ $versions ]]; then
      for version in $(echo $versions);
      do; asdf uninstall $lang $version; done;
    fi
  fi
}
