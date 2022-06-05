#!/bin/bash

# Load dependencies
source ~/.basher/lib/messagehandler.sh
source ~/.basher/lib/inihandler.sh
source ~/.basher/lib/flaghandler.sh

# Define parameters
[ $# -eq 0 ] && genericException "Path to file not defined\n$(commandHelpInfoMessage mdv 0 0)" 1 1
declare parameters must_reset file_path use_pandoc tmp
parameters=$*
must_reset=$(hasFlag --reset $parameters) && parameters=$(pruneFlag --reset $parameters)
parameters=(${parameters// / })
[ ${#parameters[@]} -ne 1 ] && noValidOptionsException mdv 1 1
file_path=${parameters[0]}
[ ! -f "${file_path}" ] && genericException "File not found at $(color yellow)${file_path}$(color)" 1 1

# Validate if ~/.basher/src/mdv/var/config.ini needs to be resetted
if [ ${must_reset} -eq 0 ]; then
    must_reset=1
    use_pandoc=$(getINIVar ~/.basher/src/mdv/var/config.ini use_pandoc)
    if [ ! -f ~/.basher/src/mdv/var/config.ini ]; then
        genericWarnMessage "config.ini file doesn't exists so it must be setted" 1 0
    elif [ "${use_pandoc}" != "0" ] && [ "${use_pandoc}" != "1" ]; then
        genericWarnMessage "config.ini file must be setted due to not valid value setted" 1 0
    else
        must_reset=0
    fi
fi

# Reset config.ini file if necessary
if [ ${must_reset} -eq 1 ]; then
    # Create config.ini file if is first use or clean it if already exists
    commandBlockHeading "SETTING MDV CONFIGURATION" 1 0
    if [ ! -f ~/.basher/src/mdv/var/config.ini ]; then
        touch ~/.basher/src/mdv/var/config.ini
    else
        echo "" >~/.basher/src/mdv/var/config.ini
    fi

    # Write header information at config.ini file
    echo "# Use pandoc as MarkDown Viewer (recommended)." >~/.basher/src/mdv/var/config.ini
    echo "#   In case you decide to use pandoc and is not installed, it will be installed on your machine, so you will need sudo access." >>~/.basher/src/mdv/var/config.ini
    echo "#   If you decide to not use pandoc or it couln't be installed, less will be used as MarkDown viewer." >>~/.basher/src/mdv/var/config.ini
    genericInfoMessage "config.ini file headers were written" 0 0

    # Ask user if want to use pandoc
    use_pandoc=-1
    while [ ${use_pandoc} -eq -1 ]; do
        genericExecutionMessage "\c" 0 0 && read -p "Would you like to use pandoc to view Markdown files? (Recomended) [y/n]: " user_answer
        if [ "$user_answer" = "y" ] || [ "$user_answer" = "Y" ]; then
            use_pandoc=1
        elif [ "$user_answer" = "n" ] || [ "$user_answer" = "N" ]; then
            use_pandoc=0
        else
            genericWarnMessage "Wrong answer! Valid options are y or n" 0 0
        fi
    done
    echo "use_pandoc=${use_pandoc}" >>~/.basher/src/mdv/var/config.ini
    genericInfoMessage "mdv configuration setted" 0 1
fi

# Check if pandoc must be used
# returns:
#    1 :: pandoc can be used and is installed
#    0 :: pandoc can't be used
#   -1 :: pandoc can be used but is not installed
function canUsePandoc() {
    use_pandoc=$(getINIVar ~/.basher/src/mdv/var/config.ini use_pandoc)
    if [ ${use_pandoc} -eq 1 ] && [ -z "$(whereis pandoc | sed -e "s/pandoc://" -e "s/ //g")" ]; then
        echo -1
    else
        echo ${use_pandoc}
    fi
}
use_pandoc=$(canUsePandoc)

# Show result if pandoc won't be used
[ ${use_pandoc} -eq 0 ] && less -c "${file_path}" && exit

# Show result if pandoc will be used
[ ${use_pandoc} -eq 1 ] && pandoc -f markdown -t plain "${file_path}" | less -c && exit

# Try to install pandoc
[ ${must_reset} -eq 0 ] && echo -e ""
genericWarnMessage "Pandoc is not installed!" 0 0
genericInfoMessage "You may need type $(color cyan)sudo$(color) password to install pandoc" 0 0
sudo echo -e "$(genericExecutionMessage "Trying to install $(color yellow)pandoc$(color)..." 0 0)\c"
if [ $? -eq 0 ]; then
    tmp=tmp=$(sudo apt-get update 2>&1) && tmp=$(sudo apt-get -y install pandoc 2>&1)
    responseString $?
fi
if [ $(canUsePandoc) -eq -1 ]; then
    genericErrorMessage "Something went wrong while installing $(color yellow)pandoc$(color)" 0 0
    genericInfoMessage "$(color yellow)less$(color) will be used to show files" 0 1
    setINIVar ~/.basher/src/mdv/var/config.ini use_pandoc 0
else
    genericInfoMessage "$(color yellow)pandoc$(color) was installed" 0 1
fi
basher mdv "${file_path}"
