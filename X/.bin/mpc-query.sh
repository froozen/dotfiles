#/bin/sh

host=""

if [[ $1 == "query" ]]
then
    python ~/.bin/mpc-info.py $host
else
    mpc -h $host $*
fi
