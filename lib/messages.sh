#!/bin/bash

# Print a message using escaped echo command.
# $1 message
# $2 spacing. none empty or invalid
#   'none'    No before or after empty line
#   'before'  Before empty line only
#   'after'   After empty line only
#   'both'    Before and after empty lines
function printMessage() {
    if [ "$2" = "both" ]; then
        echo -e "\n$1\n"
    elif [ "$2" = "after" ]; then
        echo -e "$1\n"
    elif [ "$2" = "before" ]; then
        echo -e "\n$1"
    else
        echo -e "$1"
    fi
}

# Prints a formatted error message
# $1 error message
# $2 spacing. @see printMessage
function printErrorMessage() {
    if [ ! -z "$1" ]; then
        printMessage "\e[31m$1\e[0m" "$2"
    else
        printMessage "\e[31mERROR\e[0m" "$2"
    fi
}

# Prints a formatted information message
# $1 information message
# $2 spacing. @see printMessage
function printInfoMessage() {
    if [ ! -z "$1" ]; then
        printMessage "\e[34m$1\e[0m" "$2"
    else
        printMessage "\e[34mINFO\e[0m" "$2"
    fi
}

# Prints a formatted warning message
# $1 information message
# $2 spacing. @see printMessage
function printWarningMessage() {
    if [ ! -z "$1" ]; then
        printMessage "\e[33m$1\e[0m" "$2"
    else
        printMessage "\e[33mWARNING\e[0m" "$2"
    fi
}
