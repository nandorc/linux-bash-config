#!/bin/bash

# Dependencies
source ~/.basher/lib/messages.sh
source ~/.basher/lib/flagger.sh

if [ "$1" = "--help" ]; then
    basher mdv ~/.basher/src/boot/README.md
elif [ "$1" = "reset" ]; then
    ~/.basher/src/boot/cmd/reset.sh $(pruneFlag reset $*)
elif [ "$1" == "enable" ]; then
    ~/.basher/src/boot/cmd/enable.sh $(pruneFlag enable $*)
else
    printErrorMessage "No valid options received." before
    printWarningMessage "Type 'basher boot --help' to see available options." after
fi
