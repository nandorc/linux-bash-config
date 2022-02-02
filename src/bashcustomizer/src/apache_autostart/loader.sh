#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh
source ~/.basher/src/bashcustomizer/lib/local/executor.sh

# Check and load apache service
printMessage "Checking apache service..."
if [[ "$(service apache2 status)" =~ "is not running" ]]; then
    wrapCommand "Starting apache service..." "sudo service apache2 start"
else
    printMessage "done"
fi
