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
