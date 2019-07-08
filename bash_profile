#!/bin/bash

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\n\$ "

#brew/keg bison priority
export PATH="/usr/local/opt/bison/bin:$PATH"
#shared scripts
export PATH="$PATH:$HOME/scripts:./scripts"

# useful aliases
. ~/scripts/bash_aliases

# prompt
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
#. bash_ps1
