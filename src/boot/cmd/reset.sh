#!/bin/bash

# Dependencies
source ~/.basher/lib/inihandler.sh
source ~/.basher/lib/flagger.sh
source ~/.basher/lib/wrapper.sh

# Set variables
useColor=1
[ $(hasFlag --no-color $*) -eq 1 ] && useColor=0
spacing=$(getFlagValue --spacing $*)
[ -z "$spacing" ] && spacing=both

# Begin message
printColoredMessage "Resetting features.ini file..." $(transformBeforeSpacing $spacing) $useColor

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

# End message
printColoredMessage "done" $(transformAfterSpacing $spacing) $useColor

# Unset variables
unset useColor spacing
