#!/bin/bash
function checkCustomization() {
    # $1 customization variable name without prefix
    var="custom_bash_$1"
    if [ -n "${!var}" ] && [ "${!var}" == "on" ] && [ -f ~/.bash_utilities/src/bashcustomize/customs/"$1".sh ]; then
        echo 1
    else
        echo 0
    fi
}

function includeCustomization() {
    # $1 customization name
    if [ ! -z "$1" ]; then
        . ~/.bash_utilities/src/bashcustomize/customs/"$1".sh
    fi
}
