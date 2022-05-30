#!/bin/bash

# Load dependencies
source ~/.basher/lib/colorhandler.sh

# Wraps messages for services actions
# $1 message
# $2 has_space_before
# $3 has_space_after
# $4 is_silent
# $5 is_exception
function wrap() {
    declare message has_space_before has_space_after is_silent is_exception
    message=$1 && has_space_before=$2 && has_space_after=$3 && is_silent=$4 && is_exception=$5
    [ -n "${has_space_before}" ] && [ "${has_space_before}" != "0" ] && has_space_before=1
    [ -z "${has_space_before}" ] && has_space_before=0
    [ -n "${has_space_after}" ] && [ "${has_space_after}" != "0" ] && has_space_after=1
    [ -z "${has_space_after}" ] && has_space_after=0
    [ -n "${is_silent}" ] && [ "${is_silent}" != "0" ] && is_silent=1
    [ -z "${is_silent}" ] && is_silent=0
    [ -n "${is_exception}" ] && [ "${is_exception}" != "0" ] && is_exception=1
    [ -z "${is_exception}" ] && is_exception=0
    [ ${has_space_before} -eq 1 ] && echo ""
    [ ${is_silent} -eq 0 ] && echo -e "${message}"
    [ ${has_space_after} -eq 1 ] && echo ""
    [ ${is_exception} -eq 1 ] && exit 1
    return 0
}

# Returns a string based on response code
# $1 res_cod
function getResponseString() {
    declare res_cod
    res_cod=$1
    [ $res_cod -eq 0 ] && echo "$(color green)DONE$(color)"
    [ $res_cod -ne 0 ] && echo "$(color red)FAIL$(color)"
    return 0
}

# Displays a message based on response code
# $1 res_cod
function showResponseString() {
    declare res_cod
    res_cod=$1
    echo -e "$(getResponseString ${res_cod})"
    return 0
}

# Get a generic message to point user to helper command
# $1 command_name
function getCommandHelpInfoMessage() {
    declare command_name
    command_name=$1
    echo "$(color light-blue)INF~$(color) Type $(color yellow)basher help ${command_name}$(color) to know how to use the command"
    return 0
}

# Displays an Exception
# $1 message
# $2 has_space_before
# $3 has_space_after
function genericException() {
    declare message has_space_before has_space_after
    message=$1 && has_space_before=$2 && has_space_after=$3
    wrap "$(color red)ERR~$(color) ${message}" "${has_space_before}" "${has_space_after}" 0 1
    return 0
}

# Displays no valid options message
# $1 command_name
# $2 has_space_before
# $3 has_space_after
function noValidOptionsException() {
    declare command_name has_space_before has_space_after
    command_name=$1 && has_space_before=$2 && has_space_after=$3
    genericException "No valid parameters sent to command\n$(getCommandHelpInfoMessage "${command_name}")" "${has_space_before}" "${has_space_after}"
    return 0
}

# Display no sudo privileges message
# $1 has_space_before
# $2 has_space_after
function noSudoPrivilegesException() {
    declare has_space_before has_space_after
    has_space_before=$1 && has_space_after=$2
    genericException "No $(color cyan)sudo$(color) privileges provided" "${has_space_before}" "${has_space_after}"
    return 0
}
