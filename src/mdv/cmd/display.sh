#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh
source ~/.basher/src/mdv/lib/pandoc.sh

# View a file using pandoc or less command depending on use_pandoc_mdviewer variable at .tools/etc/config.ini
# $1 file path
function viewMDFile() {
    can_use=$(canUsePandoc)
    if [ $can_use -eq 0 ]; then
        less -c "$1"
    elif [ $can_use -eq 1 ]; then
        pandoc -f markdown -t plain "$1" | less -c
    else
        printWarningMessage "* pandoc is not installed! Trying to install it." before
        installPandoc
        if [ $(canUsePandoc) -eq -1 ]; then
            printErrorMessage "pandoc installation failed. less will be used to show files." after
            setINIVar ~/.basher/src/mdv/etc/config.ini use_pandoc_mdviewer 0
        else
            printInfoMessage "pandoc was intalled!" after
        fi
        viewMDFile "$1"
    fi
    unset can_use
}

# Create config.ini file if is first use
if [ "$(getINIVar ~/.basher/src/mdv/etc/config.ini use_pandoc)" = "undefined" ]; then
    printWarningMessage "* basher mdv configuration not defined. Must define before using." before
    ~/.basher/src/mdv/cmd/reset.sh
fi

# Execute command
if [ ! -f "$1" ]; then
    printErrorMessage "File not found at $1" both
else
    viewMDFile "$1"
fi
