#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR="vim"

export PS1_RED="\033[00;31m"
export PS1_BLUE="\033[1;34m"
export PS1_GREEN="\033[1;36m"
export PS1_RESET="\033[m"

export PROMPT_COMMAND=__prompt_command

function __bash_git_prompt_custom {
    branch=`git branch 2> /dev/null | grep "^*" | colrm 1 2`
    if [[ $branch != "" ]]
    then
        echo "$branch "
    fi
}

function __pwd_color {
    if [[ $(id -u) == 0 ]]
    then
        echo "\[$PS1_RED\]"
    else
        echo "\[$PS1_BLUE\]"
    fi
}

function __prompt_command {
    PS1="\[$PS1_GREEN\]$(__bash_git_prompt_custom)\[$PS1_RESET\]$(__pwd_color)\W\[$PS1_RESET\] → "
}

alias g='git'
alias ls='ls --color=auto'

alias wine32='WINEARCH=win32 WINEPREFIX=~/.win32'
alias wine64='WINEPREFIX=~/.win64'
