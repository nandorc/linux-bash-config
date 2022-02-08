#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh

# Create config.ini file if is first use or clean it if already exists
printInfoMessage "Preparing config.ini file..." before
if [ ! -d ~/.basher/src/mdv/etc ]; then
    mkdir -p ~/.basher/src/mdv/etc
fi
if [ ! -f ~/.basher/src/mdv/etc/config.ini ]; then
    touch ~/.basher/src/mdv/etc/config.ini
    printMessage "* config.ini file created."
else
    echo "" >~/.basher/src/mdv/etc/config.ini
    printMessage "* config.ini file cleaned."
fi

# Write header information at config.ini file
echo "# Use pandoc as MarkDown Viewer (recommended)." >~/.basher/src/mdv/etc/config.ini
echo "#   In case you decide to use pandoc and is not installed, it will be installed on your machine, so you will need sudo access." >>~/.basher/src/mdv/etc/config.ini
echo "#   If you decide to not use pandoc or it couln't be installed, less will be used as MarkDown viewer." >>~/.basher/src/mdv/etc/config.ini
printMessage "* config.ini file headers were written."

# Ask user if want to use pandoc
use_pandoc=-1
while [ $use_pandoc -eq -1 ]; do
    read -p "Would you like to use pandoc to view Markdown files? (Recomended) [y/n]: " user_answer
    if [ "$user_answer" = "y" ] || [ "$user_answer" = "Y" ]; then
        use_pandoc=1
    elif [ "$user_answer" = "n" ] || [ "$user_answer" = "N" ]; then
        use_pandoc=0
    else
        printWarningMessage "Wrong answer! Valid options are y or n. Try again."
    fi
done
echo "use_pandoc=$use_pandoc" >>~/.basher/src/mdv/etc/config.ini
unset user_answer use_pandoc
printInfoMessage "config.ini file ready" after
