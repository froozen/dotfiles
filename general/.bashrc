#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR="vim"

function __bash_prompt_custom {
    branch=`git branch 2> /dev/null | grep "^*" | colrm 1 2`
    if [[ $branch != "" ]]
    then
        echo "$branch "
    fi
}

PS1='\e[1;36m$(__bash_prompt_custom)\e[m\e[1;34m\W\e[m → '

alias g='git'
alias ls='ls --color=auto'

alias wine32='WINEARCH=win32 WINEPREFIX=~/.win32'
alias wine64='WINEPREFIX=~/.win64'
