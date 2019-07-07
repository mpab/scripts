#!/bin/bash

alias ls='ls -GFh'
alias ll='ls -la'

#grep highlighting
alias grep='grep --color=auto'

#GNU tools
alias md5sum=gmd5sum
alias realpath=grealpath

#PYTHON VIRTUAL ENVIRONMENTS
alias venv="python3 -m venv"
alias ve=". venv/bin/activate"
alias ve3-create="rm -rf venv3 && ./src/bash/buildils/virtualenvry.sh"
alias ve3-protobuf="ve3 && pip uninstall -y protobuf && pip install protobuf==3.5.1 --install-option='--cpp_implementation'"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#fancy prompt
alias ps1=". bash_ps1"
