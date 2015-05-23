#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR="vim"

PS1='\e[1;34m\W\e[m > '

alias g='git'
alias ls='ls --color=auto'

alias wine32='WINEARCH=win32 WINEPREFIX=~/.win32'
alias wine64='WINEPREFIX=~/.win64'

source ~/.git-completion.bash
