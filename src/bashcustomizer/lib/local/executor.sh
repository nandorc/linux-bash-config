#!/bin/bash

# Load dependencies
source ~/.bash_utilities/lib/ext/dsoft/messages.sh

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

# $1 input spacing
function applyAfterTransformSpacing() {
    if [ "$(transformAfterSpacing "$1")" = "after" ]; then
        echo ""
    fi
}

# $1 message
# $2 spacing
# $3 colored
function printColoredMessage() {
    if [ $3 -eq 1 ]; then
        printInfoMessage "$1" "$2"
    else
        printMessage "$1" "$2"
    fi
}

# Wrap a command execution between two messages
# $1 color
#   --colored
# $2 begin message
# $3 command
# $4 spacing @see ~/.bash_utilities/lib/ext/dsoft/messages.sh/printMessage
function wrapCommand() {
    if [ "$1" = "--colored" ]; then
        colored=1 && message="$2" && command="$3" && spacing="$4"
    else
        colored=0 && message="$1" && command="$2" && spacing="$3"
    fi
    printColoredMessage "$message" "$(transformBeforeSpacing "$spacing")" "$colored"
    $command && printColoredMessage "done" "$(transformAfterSpacing "$spacing")" "$colored"
    unset colored message command spacing
}
