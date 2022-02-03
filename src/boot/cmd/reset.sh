#!/bin/bash

# Dependencies
source ~/.basher/lib/inihandler.sh
source ~/.basher/lib/wrapper.sh

# Set variables and begin message
options=$(getRebuildedOptions $*)
printColoredMessage "Resetting features.ini file..." --wrap-position begin $options

# Create etc directory if doesn't exists
if [ ! -d ~/.basher/src/boot/etc ]; then
    mkdir -p ~/.basher/src/boot/etc
    printMessage "* etc directory created."
fi

# Delete current features.ini file if exists
if [ -f ~/.basher/src/boot/etc/features.ini ]; then
    rm -rf ~/.basher/src/boot/etc/features.ini
    printMessage "* Current features.ini file deleted."
fi

# Create new features.ini
touch ~/.basher/src/boot/etc/features.ini
printMessage "* New features.ini file created."

# Save default values
setINIVar ~/.basher/src/boot/etc/features.ini git on
printMessage "* Default values stored in features.ini file."

# Unset variables and end message
printColoredMessage "features.ini file resetted" --wrap-position end $options
unset options
