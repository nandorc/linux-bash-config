#!/bin/bash

# Set colors defined at var/colors.ini
#   In case color doesn't exists returns and empty string.
# $1 color name
function color() {
    declare name=$1
    if [ -f ~/.basher/var/colors.ini ]; then
        declare color_var=$(cat ~/.basher/var/colors.ini | grep "^$name=")
        if [ -n "$color_var" ]; then
            declare color_array=(${color_var//=/ })
            echo ${color_array[1]}
        fi
    fi
}
