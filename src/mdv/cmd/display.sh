#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh
source ~/.basher/lib/inihandler.sh
source ~/.basher/src/mdv/lib/pandoc.sh

if [ ! -f "$1" ]; then
    printErrorMessage "File not found at '$1'" both
else
    can_use=$(canUsePandoc)
    if [ $can_use -eq 0 ]; then
        less -c "$1"
    elif [ $can_use -eq 1 ]; then
        pandoc -f markdown -t plain "$1" | less -c
    else
        printWarningMessage "* pandoc is not installed! Trying to install it" before
        installPandoc
        if [ $(canUsePandoc) -eq -1 ]; then
            printErrorMessage "pandoc installation failed so less will be used to show files" after
            setINIVar ~/.basher/src/mdv/var/config.ini use_pandoc 0
        else
            printInfoMessage "pandoc was intalled!" after
        fi
        basher mdv "$1"
    fi
    unset can_use
fi
