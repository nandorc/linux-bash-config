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
    java_services=$(pgrep java)
    service_pid=$(echo $java_services | grep "^$(cat ~/.basher/src/elasticsearch/var/pid)$")
    if [ -z "$service_pid" ] && [ ! -z "$java_services" ]; then
        warning=" * elasticsearch service pid doesn't match so basher isn't able to stop it"
    elif [ -z "$java_services" ]; then
        warning=" * no java services currently running so basher isn't able to stop elasticsearch service"
    else
        pkill -F ~/.basher/src/elasticsearch/var/pid
        while [ $(basher elasticsearch:status --output bool) -eq 1 ]; do
            sleep 2
        done
        rm -f ~/.basher/src/elasticsearch/var/pid
        printColoredMessage " * elasticsearch service stopped" --wrap-position end --no-color $options
    fi
    unset service_pid java_services
fi
[ -n "$warning" ] && echo "$warning" >>~/.basher/src/elasticsearch/var/warning && printColoredMessage "$warning" --type warning --wrap-position end $(pruneFlag --no-color $options)
unset options warning
