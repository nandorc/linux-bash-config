#!/bin/bash

# Load dependencies
source ~/.basher/lib/inihandler.sh

# Check if a customization can be included
# $1 customization name
function checkCustomization() {
    val=$(getINIVar ~/.basher/src/bashcustomizer/etc/vars.ini "$1")
    if [ "$val" = "on" ] && [ -f ~/.basher/src/bashcustomizer/src/"$1"/loader.sh ]; then
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
        . ~/.basher/src/bashcustomizer/src/"$1"/loader.sh
    fi
}
