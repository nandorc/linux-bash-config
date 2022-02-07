#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

options=$(getRebuildedOptions $*)
printColoredMessage "Restarting elasticsearch service..." --wrap-position begin $options
if [ $(basher elasticsearch:status --output bool) -eq 1 ]; then
    basher elasticsearch:stop --no-color --spacing none && [ -z "$(cat ~/.basher/src/elasticsearch/var/warning)" ] && basher elasticsearch:start --no-color --spacing none
else
    basher elasticsearch:start --no-color --spacing none
fi
if [ -z "$(cat ~/.basher/src/elasticsearch/var/warning)" ]; then
    printColoredMessage "restarting process finished correctly" --wrap-position end $options
else
    printColoredMessage "restarting process finished with warnings" --wrap-position end --type warning $(pruneFlag --no-color $options)
fi
unset serviceName options
