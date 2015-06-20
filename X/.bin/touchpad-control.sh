#!/bin/sh

touchpadId=12
touchpadProps=`xinput list-props $touchpadId`
pattern="Device Enabled \\(140\\): *1"
if [[ $touchpadProps == *"Synaptics TouchPad"* ]]
    then
    echo $touchpadProps | egrep -qo "$pattern"
    case $1 in
        "toggle"*)
            if [[ $? -eq 0 ]]
            then
                xinput disable $touchpadId
            else
                xinput enable $touchpadId
            fi
            ;;
        "query"*)
            if [[ $? -eq 0 ]]
            then
                echo "<fc=#ff0000><icon=mouse_01.xbm/></fc>"
            else
                echo "<icon=mouse_01.xbm/>"
            fi
            ;;
    esac
fi
