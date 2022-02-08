#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

options=$(getRebuildedOptions $*)
printColoredMessage "Stoping elasticsearch service..." --wrap-position begin $options
rm -f ~/.basher/src/elasticsearch/var/warning && touch ~/.basher/src/elasticsearch/var/warning && warning=""
if [ $(basher elasticsearch:status --output bool) -eq 0 ]; then
    printMessage " * elasticsearch service is currently stopped or not reachable"
elif [ ! -f ~/.basher/src/elasticsearch/var/pid ]; then
    warning=" * stopping elasticsearch service fails because it wasn't started by basher"
else
    javaServices=$(pgrep java) && javaServicesArray=(${javaServices// / })
    if [ -z "$javaServices" ]; then
        warning=" * no java services currently running so basher isn't able to stop elasticsearch service"
    else
        servicePid=$(cat ~/.basher/src/elasticsearch/var/pid) && serviceFound=0
        for i in "${javaServicesArray[@]}"; do
            [ "$i" = "$servicePid" ] && serviceFound=1 && break
        done
        if [ $serviceFound -eq 0 ]; then
            warning=" * elasticsearch service pid doesn't match so basher isn't able to stop it"
        else
            pkill -F ~/.basher/src/elasticsearch/var/pid
            while [ $(basher elasticsearch:status --output bool) -eq 1 ]; do
                sleep 2
            done
            rm -f ~/.basher/src/elasticsearch/var/pid
            printColoredMessage " * elasticsearch service stopped" --wrap-position end --no-color $options
        fi
        unset servicePid serviceFound
    fi
    unset javaServices javaServicesArray
fi
[ -n "$warning" ] && echo "$warning" >>~/.basher/src/elasticsearch/var/warning && printColoredMessage "$warning" --type warning --wrap-position end $(pruneFlag --no-color $options)
unset options warning
