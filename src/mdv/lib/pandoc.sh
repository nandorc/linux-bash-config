#!/bin/bash

# Load dependencies
source ~/.basher/lib/inihandler.sh

# Install pandoc
function installPandoc() {
    sudo apt update
    sudo apt install pandoc
}

# Check if pandoc can be used
# returns:
#    1 :: pandoc can be used and is installed
#    0 :: pandoc can't be used
#   -1 :: pandoc can be used but is not installed
function canUsePandoc() {
    use_pandoc=$(getINIVar ~/.basher/src/mdv/etc/config.ini use_pandoc)
    if [ -z "$use_pandoc" ] || [ "$use_pandoc" = "undefined" ] || [ $use_pandoc -eq 0 ]; then
        echo 0
    elif [ -z "$(whereis pandoc | sed -e "s/pandoc://" -e "s/ //g")" ]; then
        echo -1
    else
        echo 1
    fi
    unset use_pandoc
}
