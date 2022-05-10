#!/bin/bash

export PATH="$PATH:$HOME/code/useful-things/scripts/shell"
export PLUGIN="$HOME/.extra"
export DOTFILES="$HOME/code/useful-things/dotfiles"
export SHELL="$HOME/code/useful-things/scripts/shell"
# green prompt
PS1='\[\e[1;32m\][\u@\h \w]\$\[\e[0m\]'
# cuts directories shown in path to 3 
PROMPT_DIRTRIM=3
# disable ctrl-s ctrl-q
stty -ixon
# cd into directory by just typing name
shopt -s autocd
#append to history dont overwrite
shopt -s histappend
#save multi-line commands as one command
shopt -s cmdhist
#ignore duplicate entries
HISTCONTROL="erasedups:ignoreboth"
# practically infinite history
HISTSIZE=500000
HISTFILESIZE=100000
#type part of command and use arrow keys to autofill
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# syncs wsl system clock with windows.
# special permission was given in /etc/sudoers.d
# to execute without a password for sudo for this 
# command specifically
sudo hwclock -s

# load aliases and libraries
# full list of bash specifics are in plugins.txt
# other notables mentions: hstr
if [ -e "$SHELL/loadToBash.sh" ]; then
    source loadToBash.sh 
fi

# set configs for bash git prompt
GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_SHOW_UNTRACKED_FILES=normal