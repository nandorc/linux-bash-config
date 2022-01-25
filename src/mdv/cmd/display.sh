#!/bin/bash

# Load dependencies
source ~/.bash_utilities/lib/ext/dsoft/messages.sh
source ~/.bash_utilities/lib/ext/dsoft/inihandler.sh

# Check if pandoc can be used
# returns:
#    1 :: pandoc can be used and is installed
#    0 :: pandoc can't be used
#   -1 :: pandoc can be used but is not installed
function canUsePandoc() {
    use_pandoc=$(getINIVar ~/.bash_utilities/src/mdv/etc/config.ini use_pandoc)
    if [ -z "$use_pandoc" ] || [ "$use_pandoc" = "undefined" ] || [ $use_pandoc -eq 0 ]; then
        echo 0
    elif [ -z "$(whereis pandoc | sed -e "s/pandoc://" -e "s/ //g")" ]; then
        echo -1
    else
        echo 1
    fi
    unset use_pandoc
}

# Install pandoc
function installPandoc() {
    sudo apt update
    sudo apt install pandoc
}

# View a file using pandoc or less command depending on use_pandoc_mdviewer variable at .tools/etc/config.ini
# $1 file path
function viewMDFile() {
    can_use=$(canUsePandoc)
    if [ $can_use -eq 0 ]; then
        less -c "$1"
    elif [ $can_use -eq 1 ]; then
        pandoc -f markdown -t plain "$1" | less -c
    else
        printWarningMessage "pandoc is not installed! Trying to install it." before
        installPandoc
        if [ $(canUsePandoc) -eq -1 ]; then
            printErrorMessage "pandoc installation failed. less will be used to show files." after
            setINIVar ~/.bash_utilities/src/mdv/etc/config.ini use_pandoc_mdviewer 0
        else
            printInfoMessage "pandoc was intalled!" after
        fi
        viewMDFile "$1"
    fi
    unset can_use
}

# Create config.ini file if is first use
if [ "$(getINIVar ~/.bash_utilities/src/mdv/etc/config.ini use_pandoc)" = "undefined" ]; then
    printWarningMessage "mdv configuration not defined. Must define before using." before
    ~/.bash_utilities/src/mdv/cmd/reset.sh
fi

# Execute command
if [ ! -f "$1" ]; then
    printErrorMessage "File not found at $1" both
else
    viewMDFile "$1"
fi
