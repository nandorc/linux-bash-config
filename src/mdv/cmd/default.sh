#!/bin/bash

# Load dependencies
source ~/.basher/lib/colorhandler.sh
source ~/.basher/lib/inihandler.sh
source ~/.basher/lib/flagger.sh

# Define parameters
[ $# -eq 0 ] && echo -e "\n$(color red)Execution Exception:$(color none) Path to file not defined\nType $(color yellow)basher help mdv$(color none) to know how to use the command\n" && exit 1
parameters=$*
must_reset=$(hasFlag --reset $parameters) && parameters=$(pruneFlag --reset $parameters)
parameters=(${parameters// / })
[ ${#parameters[@]} -ne 1 ] && echo -e "\n$(color red)Execution Exception:$(color none) Invalid parameters received\nType $(color yellow)basher help mdv$(color none) to know how to use the command\n" && exit 1
file_path=${parameters[0]}
[ ! -f "$file_path" ] && echo -e "\n$(color red)Execution Exception:$(color none) File not found at $(color yellow)$file_path$(color none)\n" && exit 1

# Validate if ~/.basher/src/mdv/var/config.ini needs to be resetted
[ $must_reset -eq 0 ] && [ ! -f ~/.basher/src/mdv/var/config.ini ] && must_reset=1
is_invalid_value=0
use_pandoc=$(getINIVar ~/.basher/src/mdv/var/config.ini use_pandoc)
[ "$use_pandoc" = "undefined" ] || [ -z "$use_pandoc" ] && is_invalid_value=1
[ "$use_pandoc" != "0" ] && [ "$use_pandoc" != "1" ] && is_invalid_value=1
[ $must_reset -eq 0 ] && [ $is_invalid_value -eq 1 ] && must_reset=1

# Reset config.ini file if necessary
if [ $must_reset -eq 1 ]; then
    # Inform if value is invalid
    [ $is_invalid_value -eq 1 ] && echo -e "\n$(color yellow)WARNING!$(color none) config.ini file must be resetted due to not valid value setted\n"

    # Create config.ini file if is first use or clean it if already exists
    is_first_set=0
    [ ! -f ~/.basher/src/mdv/var/config.ini ] && is_first_set=1
    echo -e "\n$(color green)START: $(color none)\c"
    if [ $is_first_set -eq 1 ]; then
        touch ~/.basher/src/mdv/var/config.ini
        echo -e "Setting mdv configuration"
    else
        echo "" >~/.basher/src/mdv/var/config.ini
        echo -e "Resetting mdv configuration"
    fi

    # Write header information at config.ini file
    echo "# Use pandoc as MarkDown Viewer (recommended)." >~/.basher/src/mdv/var/config.ini
    echo "#   In case you decide to use pandoc and is not installed, it will be installed on your machine, so you will need sudo access." >>~/.basher/src/mdv/var/config.ini
    echo "#   If you decide to not use pandoc or it couln't be installed, less will be used as MarkDown viewer." >>~/.basher/src/mdv/var/config.ini
    echo -e "$(color blue)INFO:$(color none) config.ini file headers were written\n"

    # Ask user if want to use pandoc
    use_pandoc=-1
    while [ $use_pandoc -eq -1 ]; do
        read -p "Would you like to use pandoc to view Markdown files? (Recomended) [y/n]: " user_answer
        if [ "$user_answer" = "y" ] || [ "$user_answer" = "Y" ]; then
            use_pandoc=1
        elif [ "$user_answer" = "n" ] || [ "$user_answer" = "N" ]; then
            use_pandoc=0
        else
            echo -e "$(color yellow)Wrong answer!$(color none) Valid options are y or n\nTry again"
        fi
    done
    echo "use_pandoc=$use_pandoc" >>~/.basher/src/mdv/var/config.ini
    echo -e "\n$(color green)FINISH:$(color none) mdv configuration \c"
    if [ $is_first_set -eq 1 ]; then
        echo -e "setted\n"
    else
        echo -e "resetted\n"
    fi
fi

# Check if pandoc must be used
# returns:
#    1 :: pandoc can be used and is installed
#    0 :: pandoc can't be used
#   -1 :: pandoc can be used but is not installed
function canUsePandoc() {
    use_pandoc=$(getINIVar ~/.basher/src/mdv/var/config.ini use_pandoc)
    if [ $use_pandoc -eq 1 ] && [ -z "$(whereis pandoc | sed -e "s/pandoc://" -e "s/ //g")" ]; then
        echo -1
    else
        echo $use_pandoc
    fi
}
use_pandoc=$(canUsePandoc)

# Show result if pandoc won't be used
[ $use_pandoc -eq 0 ] && less -c "$file_path" && exit

# Show result if pandoc will be used
[ $use_pandoc -eq 1 ] && pandoc -f markdown -t plain "$file_path" | less -c && exit

# Try to install pandoc
[ $must_reset -eq 0 ] && echo -e ""
echo -e "$(color yellow)WARNING!$(color none) Pandoc is not installed!\nYou must type sudo password to install pandoc"
sudo echo -e "$(color green)START:$(color none) Trying to install $(color yellow)pandoc$(color none)" && sudo apt update && sudo apt install pandoc
if [ $(canUsePandoc) -eq -1 ]; then
    echo -e "$(color red)FAIL:$(color none) Something went wrong while installing $(color yellow)pandoc$(color none) so $(color yellow)less$(color none) will be used to show files\n"
    setINIVar ~/.basher/src/mdv/var/config.ini use_pandoc 0
else
    echo -e "$(color green)FINISH: $(color yellow)pandoc$(color none) was installed\n"
fi
basher mdv "$file_path"
