#!/bin/bash

# Dependencies
source ~/.basher/lib/messages.sh
source ~/.basher/lib/flagger.sh

if [ "$1" = "reset" ]; then
    ~/.basher/src/boot/cmd/reset.sh $(pruneFlag reset $*)
elif [ "$1" == "enable" ]; then
    ~/.basher/src/boot/cmd/enable.sh $(pruneFlag enable $*)
elif [ "$1" == "disable" ]; then
    ~/.basher/src/boot/cmd/disable.sh $(pruneFlag disable $*)
else
    printErrorMessage "No valid options received" before
    printWarningMessage "Type 'basher help boot' to know how to use the command" after
fi
