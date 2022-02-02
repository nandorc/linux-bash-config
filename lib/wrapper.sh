#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh
source ~/.basher/lib/flagger.sh

# $1 input spacing
function transformBeforeSpacing() {
    if [ "$1" = "both" ]; then
        echo before
    elif [ "$1" = "after" ]; then
        echo none
    else
        echo "$1"
    fi
}

# $1 input spacing
function transformAfterSpacing() {
    if [ "$1" = "both" ] || [ "$1" = "after" ]; then
        echo after
    else
        echo none
    fi
}

# $1 message
# $* extra params
#   --spacing spacing
#       @see ~/.basher/lib/messages.sh/printMessage
#       default: both
#   --no-color
#       points to not using colors on message
#   --type type
#       info : (default)
#       warning
#       error
#   --wrap-position position
#       begin
#       end
function printColoredMessage() {
    # Set variables
    useColor=1
    [ $(hasFlag --no-color $*) -eq 1 ] && useColor=0
    spacing=$(getFlagValue --spacing $*)
    [ -z "$spacing" ] && spacing=both
    type=$(getFlagValue --type $*)
    [ -z "$type" ] && type=info
    wrapPosition=$(getFlagValue --wrap-position $*)

    # Transform spacing if necessary
    if [ "$wrapPosition" = "begin" ]; then
        spacing=$(transformBeforeSpacing $spacing)
    elif [ "$wrapPosition" = "end" ]; then
        spacing=$(transformAfterSpacing $spacing)
    fi

    # Process message
    if [ $useColor -eq 1 ]; then
        if [ "$type" = "warning" ]; then
            printWarningMessage "$1" "$spacing"
        elif [ "$type" = "error" ]; then
            printErrorMessage "$1" "$spacing"
        else
            printInfoMessage "$1" "$spacing"
        fi
    else
        printMessage "$1" "$spacing"
    fi

    # Unset variables
    unset useColor spacing type wrapPosition
}
