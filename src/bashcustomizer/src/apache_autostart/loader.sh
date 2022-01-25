#!/bin/bash

# Load dependencies
source ~/.bash_utilities/lib/ext/dsoft/messages.sh
source ~/.bash_utilities/src/bashcustomizer/lib/local/executor.sh

printMessage "Checking apache service..."
if [[ "$(service apache2 status)" =~ "is not running" ]]; then
    wrapCommand "Starting apache service..." "sudo service apache2 start"
else
    printMessage "done"
fi
