#!/bin/bash

# Get a variable from a .ini file.
#   In case variable or .ini file doesn't exists returns 'undefined'.
# $1 file_path - .ini file path
# $2 var_name - variable name
function getINIVar() {
    declare file_path var_name var_string
    file_path=$1 && var_name=$2 && var_string=$(cat "${file_path}" |& grep "^${var_name}=")
    if [ ! -f "${file_path}" ] || [ -z "${var_string}" ]; then
        echo "undefined"
    else
        echo "${var_string}" | sed -e "s|${var_name}=||"
    fi
    return 0
}

# Set a variable on an .ini file.
# $1 file_path - .ini file path
# $2 var_name - variable name.
# $3 var_value - [Optional] variable value. If not defined is set to an empty value.
function setINIVar() {
    declare file_path var_name var_value current_value tmp
    file_path=$1 && var_name=$2 && var_value=$3
    if [ ! -f "${file_path}" ]; then
        tmp=$(touch "${file_path}" 2>&1)
        [ $? -ne 0 ] && return 1
    fi
    current_value=$(getINIVar "${file_path}" "${var_name}")
    if [ "${current_value}" = "undefined" ]; then
        echo "${var_name}=${var_value}" >>"${file_path}"
    else
        sed -i -e "s|${var_name}=\(.*\)|${var_name}=${var_value}|" "${file_path}"
    fi
    return 0
}

# Drop a defined variable
# $1 file_path - .ini file path
# $2 var_name - variable name
function dropINIVar() {
    declare file_path var_name current_value
    file_path=$1 && var_name=$2
    [ ! -f "${file_path}" ] && return 1
    current_value=$(getINIVar "${file_path}" "$var_name")
    [ "${current_value}" != "undefined" ] && sed -i "\!${var_name}=!d" "${file_path}"
    return 0
}
