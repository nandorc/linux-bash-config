#!/bin/bash

# Dependencies
source ~/.basher/lib/wrapper.sh

options=$(getRebuildedOptions $*)
printColoredMessage "Restarting magento services..." --wrap-position begin $options
# Related services restart
basher apache:restart --no-color --spacing none
basher mysql:restart --no-color --spacing none
basher elasticsearch:restart --no-color --spacing none
# End message
printColoredMessage "restarting process finished" --wrap-position end $options
unset options
