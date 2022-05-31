#!/bin/bash

# Set colors defined at var/colors.ini
#   In case color doesn't exists returns and empty string.
# $* color options
function color() {
    [ ! -f ~/.basher/var/colors.ini ] && return 1
    declare text_style font_color bg_color color_var color_array color_result
    text_style="" && font_color="" && bg_color="" && color_result=""
    while [ -n "${1}" ]; do
        color_var=$(cat ~/.basher/var/colors.ini | grep "^${1}=")
        shift
        if [ -n "${color_var}" ]; then
            color_array=(${color_var//=/ })
            [ "${color_array[0]}" = "none" ] && text_style=${color_array[1]} && font_color="" && bg_color="" && break
            [ -n "$(echo ${color_array[0]} | grep "^tx-")" ] && text_style=${color_array[1]} && continue
            [ -n "$(echo ${color_array[0]} | grep "^bg-")" ] && bg_color=${color_array[1]} && continue
            font_color=${color_array[1]}
        fi
    done
    [ -n "${text_style}" ] && color_result="${color_result}${text_style}"
    [ -n "${color_result}" ] && [ -n "${font_color}" ] && color_result="${color_result};"
    [ -n "${font_color}" ] && color_result="${color_result}${font_color}"
    [ -n "${color_result}" ] && [ -n "${bg_color}" ] && color_result="${color_result};"
    [ -n "${bg_color}" ] && color_result="${color_result}${bg_color}"
    color_result="\e[${color_result}m"
    echo ${color_result}
    return 0
}

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

# Displays a generic information message
# $1 message
# $2 has_space_before
# $3 has_space_after
function genericInfoMessage() {
    declare message has_space_before has_space_after
    message=$1 && has_space_before=$2 && has_space_after=$3
    wrap "$(color light-blue)INF~$(color) ${message}" "${has_space_before}" "${has_space_after}" 0 0
    return 0
}

# Displays a generic warning message
# $1 message
# $2 has_space_before
# $3 has_space_after
function genericWarnMessage() {
    declare message has_space_before has_space_after
    message=$1 && has_space_before=$2 && has_space_after=$3
    wrap "$(color yellow)WRN~$(color) ${message}" "${has_space_before}" "${has_space_after}" 0 0
    return 0
}

# Displays a generic error message
# $1 message
# $2 has_space_before
# $3 has_space_after
function genericErrorMessage() {
    declare message has_space_before has_space_after
    message=$1 && has_space_before=$2 && has_space_after=$3
    wrap "$(color red)ERR~$(color) ${message}" "${has_space_before}" "${has_space_after}" 0 0
    return 0
}

# Displays a generic execution message
# $1 message
# $2 has_space_before
# $3 has_space_after
function genericExecutionMessage() {
    declare message has_space_before has_space_after
    message=$1 && has_space_before=$2 && has_space_after=$3
    wrap "EXE~ ${message}" "${has_space_before}" "${has_space_after}" 0 0
    return 0
}

# Displays a message to point user to type sudo password if necessary
# $1 has_space_before
# $2 has_space_after
# $3 is_silent
function mayNeedSudoMessage() {
    declare has_space_before has_space_after is_silent
    has_space_before=$1 && has_space_after=$2 && is_silent=$3
    wrap "$(genericInfoMessage "You may need to type your $(color cyan)sudo$(color) password to continue" 0 0)" "${has_space_before}" "${has_space_after}" "${is_silent}" 0
    return 0
}

# Displays command block heading
# $1 message
# $2 has_space_before
# $3 has_space_after
function commandBlockHeading() {
    declare message has_space_before has_space_after
    message=$1 && has_space_before=$2 && has_space_after=$3
    wrap "$(color tx-italic green)${message}$(color)" "${has_space_before}" "${has_space_after}" 0 0
    return 0
}

# Displays a string based on response code
# $1 res_cod
function responseString() {
    declare res_cod
    res_cod=$1
    [ $res_cod -eq 0 ] && echo -e "$(color green)DONE$(color)"
    [ $res_cod -ne 0 ] && echo -e "$(color red)FAIL$(color)"
    return 0
}

# Get a generic message to point user to helper command
# $1 command_name
# $2 has_space_before
# $3 has_space_after
function commandHelpInfoMessage() {
    declare command_name has_space_before has_space_after
    command_name=$1 && has_space_before=$2 && has_space_after=$3
    genericInfoMessage "Type $(color yellow)basher help ${command_name}$(color) to know how to use the command" "${has_space_before}" "${has_space_after}"
    return 0
}

# Displays an Exception
# $1 message
# $2 has_space_before
# $3 has_space_after
function genericException() {
    declare message has_space_before has_space_after
    message=$1 && has_space_before=$2 && has_space_after=$3
    wrap "$(genericErrorMessage "${message}" 0 0)" "${has_space_before}" "${has_space_after}" 0 1
    return 0
}

# Displays no valid options message
# $1 command_name
# $2 has_space_before
# $3 has_space_after
function noValidOptionsException() {
    declare command_name has_space_before has_space_after
    command_name=$1 && has_space_before=$2 && has_space_after=$3
    genericException "No valid parameters sent to command\n$(commandHelpInfoMessage "${command_name}" 0 0)" "${has_space_before}" "${has_space_after}"
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
