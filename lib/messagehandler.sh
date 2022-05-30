#!/bin/bash

# Load dependencies
source ~/.basher/lib/colorhandler.sh

# Wraps messages for services actions
# $1 message
# $2 no-spaces before
# $3 no-spaces after
# $4 must-skip
# $5 is_exception
function wrap() {
    declare message=$1 && declare no_spaces_before=$2 && declare no_spaces_after=$3 && declare must_skip=$4 && declare is_exception=$5
    [ -n "${no_spaces_before}" ] && [ "${no_spaces_before}" != "0" ] && no_spaces_before=1
    [ -z "${no_spaces_before}" ] && no_spaces_before=0
    [ -n "${no_spaces_after}" ] && [ "${no_spaces_after}" != "0" ] && no_spaces_after=1
    [ -z "${no_spaces_after}" ] && no_spaces_after=0
    [ -n "${must_skip}" ] && [ "${must_skip}" != "0" ] && must_skip=1
    [ -z "${must_skip}" ] && must_skip=0
    [ -n "${is_exception}" ] && [ "${is_exception}" != "0" ] && is_exception=1
    [ -z "${is_exception}" ] && is_exception=0
    [ ${no_spaces_before} -eq 0 ] && echo ""
    [ ${must_skip} -eq 0 ] && echo -e "${message}"
    [ ${no_spaces_after} -eq 0 ] && echo ""
    [ ${is_exception} -eq 1 ] && exit 1
    unset
}

# Returns a message based on response code
# $1 response code
function getResponseMessage() {
    declare res_cod=$1
    [ $res_cod -eq 0 ] && echo "$(color green)DONE$(color)"
    [ $res_cod -ne 0 ] && echo "$(color red)FAIL$(color)"
    unset
}

# Displays a message based on response code
# $1 response code
function processResponse() {
    declare res_cod=$1
    echo -e "$(getResponseMessage ${res_cod})"
    unset
}

# Displays an Exception
# $1 message
# $2 no-spaces-before
# $3 no-spaces-after
function genericException() {
    declare message=$1 && declare no_spaces_before=$2 && declare no_spaces_after=$3
    wrap "$(color red)ERR~$(color) ${message}" ${no_spaces_before} ${no_spaces_after} 0 1
    unset
}

# Displays no valid options message
# $1 command name
# $2 no-spaces-before
# $3 no-spaces-after
function noValidOptionsException() {
    declare command_name=$1 && declare no_spaces_before=$2 && declare no_spaces_after=$3
    genericException "No valid parameters sent to command\n$(color light-blue)INF~$(color) Type $(color yellow)basher help ${command_name}$(color) to know how to use the command" ${no_spaces_before} ${no_spaces_after}
    unset
}

# Display no sudo privileges message
# $1 no-spaces-before
# $2 no-spaces-after
function noSudoPrivilegesException() {
    declare no_spaces_before=$1 && declare no_spaces_after=$2
    genericException "No $(color cyan)sudo$(color) privileges provided" ${no_spaces_before} ${no_spaces_after}
    unset
}