#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh

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
# $4 type
#   info : (default)
#   warning
#   error
function printColoredMessage() {
    if [ $3 -eq 1 ]; then
        if [ "$4" = "warning" ]; then
            printWarningMessage "$1" "$2"
        elif [ "$4" = "error" ]; then
            printErrorMessage "$1" "$2"
        else
            printInfoMessage "$1" "$2"
        fi
    else
        printMessage "$1" "$2"
    fi
}

# Wrap a command execution between two messages
# $1 color
#   --colored
# $2 begin message
# $3 command
# $4 spacing @see ~/.basher/lib/messages.sh/printMessage
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

# Wrap file inclusion
# $1 color
#   --colored
# $2 begin message
# $3 file path
# $4 spacing @see ~/.basher/lib/messages.sh/printMessage
function wrapFileInclusion() {
    if [ "$1" = "--colored" ]; then
        colored=1 && message="$2" && path="$3" && spacing="$4"
    else
        colored=0 && message="$1" && path="$2" && spacing="$3"
    fi
    notFound=0
    if [[ "$path" =~ "~/" ]]; then
        useHome=1
        path=$(echo "$path" | sed -e "s|~/||")
        [ ! -f ~/"$path" ] && notFound=1
    else
        useHome=0
        [ ! -f "$path" ] && notFound=1
    fi
    if [ $notFound -eq 1 ]; then
        printColoredMessage "No file found at $path" "$spacing" "$colored" error
    else
        printColoredMessage "$message" "$(transformBeforeSpacing "$spacing")" "$colored"
        if [ $useHome -eq 1 ]; then
            . ~/"$path"
        else
            . "$path"
        fi
        printColoredMessage "done" "$(transformAfterSpacing "$spacing")" "$colored"
    fi
    unset colored message command spacing useHome
}
