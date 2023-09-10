#!/bin/env zsh

function onzshtime() {
 
  for ((i = 0; i < 5; i++)); do
    time zsh --interactive -c exit
  done

}

