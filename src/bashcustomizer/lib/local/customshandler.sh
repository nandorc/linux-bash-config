#!/bin/bash

# Load dependencies
source ~/.bash_utilities/lib/ext/dsoft/inihandler.sh

# Check if a customization can be included
# $1 customization name
function checkCustomization() {
    val=$(getINIVar ~/.bash_utilities/src/bashcustomizer/etc/vars.ini "$1")
    if [ "$val" = "on" ] && [ -f ~/.bash_utilities/src/bashcustomizer/src/"$1".sh ]; then
        echo 1
    else
        echo 0
    fi
    unset val
}

# Includes a customization on execution
# $1 customization name
function includeCustomization() {
    if [ ! -z "$1" ]; then
        . ~/.bash_utilities/src/bashcustomizer/src/"$1".sh
    fi
}
