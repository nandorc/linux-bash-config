#!/bin/bash

# Load dependencies
source ~/.basher/etc/colors.sh
source ~/.basher/lib/inihandler.sh

# Define parameters
file_path=$1

# Validations
[ -z "$file_path" ] && echo -e "\n"$color_red"Execution Exception: "$color_none"Path to file not defined\nType "$color_yellow"basher help mdv"$color_none" to know how to use the command\n" && exit 1
[ ! -f "$file_path" ] && echo -e "\n"$color_red"Execution Exception: "$color_none"File not found at "$color_yellow"$file_path\n" && exit 1

# Check if pandoc must be used
# returns:
#    1 :: pandoc can be used and is installed
#    0 :: pandoc can't be used
#   -1 :: pandoc can be used but is not installed
function canUsePandoc() {
    use_pandoc=$(getINIVar ~/.basher/src/mdv/var/config.ini use_pandoc)
    if [ -z "$use_pandoc" ] || [ "$use_pandoc" = "undefined" ] || [ $use_pandoc -eq 0 ]; then
        echo 0
    elif [ -z "$(whereis pandoc | sed -e "s/pandoc://" -e "s/ //g")" ]; then
        echo -1
    else
        echo 1
    fi
}
use_pandoc=$(canUsePandoc)

# Show result if pandoc won't be used
[ $use_pandoc -eq 0 ] && less -c "$file_path" && exit

# Show result if pandoc will be used
[ $use_pandoc -eq 1 ] && pandoc -f markdown -t plain "$file_path" | less -c && exit

# Try to install pandoc
echo -e "\n"$color_yellow"WARNING!"$color_none" Pandoc is not installed!\nYou must type sudo password to install pandoc"
sudo echo -e "Trying to install "$color_yellow"pandoc"$color_none"..." && sudo apt update && sudo apt install pandoc
[ $(canUsePandoc) -eq -1 ] && echo -e "\n"$color_red"ERROR:"$color_none" Something failed while installing "$color_yellow"pandoc\nless"$color_none" will be used to show files\n" && setINIVar ~/.basher/src/mdv/var/config.ini use_pandoc 0
basher mdv "$file_path"
