#!/bin/bash

# Check if a flag is given
# $1 flag - flag to check
# $* parameters list to look
function hasFlag() {
    declare flag
    flag=$1 && shift
    while [ -n "${1}" ]; do
        [ "${1}" == "${flag}" ] && echo 1 && break
        shift
    done
    [ -z "$1" ] && echo 0
    return 0
}

# Delete a flag from list
# $1 flag - flag to delete
# $* original parameters list
function pruneFlag() {
    declare flag result param
    flag=$1 && result="" && shift
    while [ -n "${1}" ]; do
        param=$1 && shift
        if [ "${param}" != "${flag}" ]; then
            [ -z "${result}" ] && result="${param}" && continue
            result="${result} ${param}"
        fi
    done
    echo "${result}"
    return 0
}

# Get value next to a given flag
# $1 flag - flag to search
# $* parameters list to look
function getFlagValue() {
    declare flag value
    flag=$1 && shift
    while [ -n "${1}" ]; do
        if [ "${1}" == "${flag}" ]; then
            value=""
            [ -z "$(echo $2 | grep "^-")" ] && value=$2
            echo "${value}" && break
        else
            shift
        fi
    done
    [ -z "$1" ] && return 1
    return 0
}

# Delete a flag with its value from list
# $1 flag - flag to delete
# $* original parameters list
function pruneFlagValue() {
    declare flag value result param
    flag=$1 && result="" && shift
    while [ -n "${1}" ]; do
        param="${1}" value="${2}" && shift
        if [ "${param}" != "${flag}" ]; then
            [ -z "$result" ] && result="${param}" && continue
            result="${result} ${param}"
        elif [ -z "$(echo "${value}" | grep "^-")" ]; then
            shift
        fi
    done
    echo "${result}"
    return 0
}
