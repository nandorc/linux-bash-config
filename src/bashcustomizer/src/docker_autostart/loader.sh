#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh
source ~/.basher/src/bashcustomizer/lib/local/executor.sh

# Check and load apache service
printMessage "Checking docker service..."
if [[ "$(service docker status)" =~ "is not running" ]]; then
    wrapCommand 'Starting docker service...' 'sudo service docker start'
else
    printMessage "done"
fi
