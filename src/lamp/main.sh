#!/bin/bash

# Dependencies
source ~/.basher/lib/messages.sh
source ~/.basher/lib/flagger.sh

parent="lamp"
if [ "$1" = "status" ] || [ "$1" = "start" ] || [ "$1" = "stop" ] || [ "$1" = "restart" ]; then
    if [ -f ~/.basher/src/"$parent"/cmd/"$1".sh ]; then
        ~/.basher/src/"$parent"/cmd/"$1".sh $(pruneFlag $1 $*)
    else
        printWarningMessage "Command 'basher $parent:$1' not found" both
    fi
else
    printErrorMessage "No valid options received" before
    printWarningMessage "Type 'basher help $parent' to know how to use the command" after
fi
unset parent
