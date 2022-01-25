#!/bin/bash

echo "Hola"
# source .tools/lib/inihandler.sh

# # Check if pandoc can be used
# # returns:
# #    1 :: pandoc can be used and is installed
# #    0 :: pandoc can't be used
# #   -1 :: pandoc can be used but is not installed
# function canUsePandoc() {
#     use_pandoc=$(getINIVar .tools/etc/config.ini use_pandoc_mdviewer)
#     if [ -z "$use_pandoc" ] || [ "$use_pandoc" = "undefined" ] || [ $use_pandoc -eq 0 ]; then
#         echo 0
#     elif [ -z "$(whereis pandoc | sed -e "s/pandoc://" -e "s/ //g")" ]; then
#         echo -1
#     else
#         echo 1
#     fi
#     unset use_pandoc
# }

# # Install pandoc
# function installPandoc() {
#     sudo apt update
#     sudo apt install pandoc
# }

# # View a file using pandoc or less command depending on use_pandoc_mdviewer variable at .tools/etc/config.ini
# # $1 file path
# function viewMDFile() {
#     can_use=$(canUsePandoc)
#     if [ $can_use -eq 0 ]; then
#         less -c "$1"
#     elif [ $can_use -eq 1 ]; then
#         pandoc -f markdown -t plain "$1" | less -c
#     else
#         echo -e "\n\e[33mpandoc is not installed! trying to install it.\e[0m"
#         installPandoc
#         if [ $(canUsePandoc) -eq -1 ]; then
#             echo -e "\e[31mpandoc installation failed. less will be used to show files.\e[0m\n"
#             setINIVar .tools/etc/config.ini use_pandoc_mdviewer 0
#         else
#             echo -e "\e[36mpandoc was intalled!\e[0m\n"
#         fi
#         viewMDFile "$1"
#     fi
#     unset can_use
# }
