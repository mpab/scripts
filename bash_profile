#!/bin/bash

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\n\$ "

#brew/keg bison priority
export PATH="/usr/local/opt/bison/bin:$PATH"
#shared scripts
export PATH="$PATH:$HOME/scripts:./scripts"

# useful aliases
. bash_aliases

# prompt
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
#. bash_ps1

# set go path if go present
if [ $(command -v go) ]; then
    export GOPATH="$HOME/go"
    export PATH="$PATH:$GOPATH/bin"
    mkdir -p $GOPATH
fi;
