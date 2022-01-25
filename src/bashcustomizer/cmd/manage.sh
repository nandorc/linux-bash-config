#!/bin/bash

# Load dependencies
source ~/.bash_utilities/lib/ext/dsoft/messages.sh
source ~/.bash_utilities/lib/ext/dsoft/inihandler.sh

# Define variables values
#   $quiet 0/1
#   $action set/unset
#   $var variable name
#   $val variable value
if [ "$1" == "-q" ]; then
    quiet=1 && action="$2" && var="$3" && val="$4"
else
    quiet=0 && action="$1" && var="$2" && val="$3"
fi

# Create vars.ini file if not exists
if [ ! -f ~/.bash_utilities/src/bashcustomizer/etc/vars.ini ]; then
    if [ $quiet -eq 0 ]; then
        printWarningMessage "No file holding any variable found. File will be created." before
    fi
    touch ~/.bash_utilities/src/bashcustomizer/etc/vars.ini
fi

# Prints a formatted message.
# $1 Information message
function printResetNeedMessage() {
    if [ ! -z "$1" ]; then
        printInfoMessage "$1" before
    fi
    printMessage "You must restart to apply changes." after
}

# Execute command
if [ "$action" != "set" ] && [ "$action" != "unset" ]; then
    printErrorMessage "No valid action to manage variables." both
elif [ -z "$var" ]; then
    printErrorMessage "No variable name provided" both
elif [ "$action" = "set" ]; then
    setINIVar ~/.bash_utilities/src/bashcustomizer/etc/vars.ini "$var" "$val"
    if [ $quiet -eq 0 ]; then
        if [ -z "$val" ]; then
            printResetNeedMessage "'$var' setted to empty value"
        else
            printResetNeedMessage "'$var' setted with value '$val'"
        fi
    fi
else
    dropResult=$(dropINIVar ~/.bash_utilities/src/bashcustomizer/etc/vars.ini "$var")
    if [ $quiet -eq 0 ]; then
        if [ $dropResult -eq 1 ]; then
            printResetNeedMessage "'$var' was deleted"
        else
            printInfoMessage "'$var' is not a defined variable" 1
        fi
    fi
fi

# Clean variables
unset quiet action var val gropResult
