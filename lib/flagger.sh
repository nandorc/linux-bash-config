#!/bin/bash

# Get value next to a given flag
# $1 flag to search
# $* parameters list to look
function getFlagValue() {
    wantedFlag="$1" && shift
    while [ -n "$1" ]; do
        if [ "$1" = "$wantedFlag" ]; then
            echo "$2" && break
        else
            shift
        fi
    done
    unset wantedFlag
}

# Check if a flag is given
# $1 flag to check
# $* parameters list to look
function hasFlag() {
    wantedFlag="$1" && shift
    while [ -n "$1" ]; do
        if [ "$1" = "$wantedFlag" ]; then
            echo 1 && break
        else
            shift
        fi
    done
    [ -z "$1" ] && echo 0
    unset wantedFlag
}
