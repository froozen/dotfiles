#/bin/sh

# python2 ~/.bin/battery-info.py

acpiOut=`acpi`
left=`echo ${acpiOut} | grep -o -P '(\d\d:)+\d\d'`
percent=`echo ${acpiOut} | grep -oP "\d+%" | head -c 2`

if [[ $acpiOut == *"Full"* ]]
then
    echo ""
elif [[ $acpiOut == *"Charging"* ]]
then
    echo "${left}"
else
    if (( percent < 26 ))
    then
        echo "${left}"
        echo ""
        echo "#FF0000"
    elif (( percent < 51 ))
    then
        echo "${left}"
    elif (( percent < 76 ))
    then
        echo "${left}"
    else
        echo "${left}"
    fi
fi
