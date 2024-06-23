#!/bin/env zsh

function reload() {

  # source $HOME/.zshenv 
  source ${ZDOTDIR:-$HOME}/.zshrc 

}

zsh_benchmark () 
{
 
  for ((i = 0; i < 5; i++)); do
    time zsh --interactive -c exit
  done }

# set_github ()
# {
#
# env=/home/joaozeus/.ssh/agent.env
# SSH_KEY=/home/joao_linus/.ssh/github/github
#
# agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }
#
# agent_start () {
#     (umask 077; ssh-agent >|"$env")
#     . "$env" >| /dev/null ;}
#
# agent_load_env
#
# # agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
# agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
# if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
#     agent_start
#
#     ssh-add $SSH_KEY
#
# elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
#
#     ssh-add $SSH_KEY
#
# fi
#
# unset env
#
# }

#asdf_update_java_home() {
  # shellcheck disable=SC2046
#  JAVA_HOME=$(realpath $(dirname $(readlink -f $(asdf which java)))/../)
#  export JAVA_HOME
#}
#
#autoload -U add-zsh-hook
#add-zsh-hook precmd asdf_update_java_home

##lazygit 

lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}
