#!/bin/env zsh

zsh_benchmark () 
{
 
  for ((i = 0; i < 5; i++)); do
    time zsh --interactive -c exit
  done

}

github_setup ()
{

env=/home/joaozeus/.ssh/agent.env
SSH_KEY=~/.ssh/.github/git 
SSH_KEY_SING=~/.ssh/.github/sing/github_singin 

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >|"$env")
    . "$env" >| /dev/null ;}

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start

    ssh-add $SSH_KEY  
    ssh-add $SSH_KEY_SING

elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then

    ssh-add $SSH_KEY
    ssh-add $SSH_KEY_SING

fi

unset env

}
