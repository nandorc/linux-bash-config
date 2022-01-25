#!/bin/bash

# Check if a customization can be included
# $1 customization name
# $2 customization value
function checkCustomization() {
    if [ "$2" = "on" ] && [ -f ~/.bash_utilities/src/bashcustomizer/src/"$1".sh ]; then
        echo 1
    else
        echo 0
    fi
}

# Includes a customization on execution
# $1 customization name
function includeCustomization() {
    if [ ! -z "$1" ]; then
        . ~/.bash_utilities/src/bashcustomizer/src/"$1".sh
    fi
}
