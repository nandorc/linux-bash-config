#!/bin/bash

source ~/.bash_utilities/lib/ext/dsoft/messages.sh

printMessage "Checking docker service..."
if [[ "$(service docker status)" =~ "is not running" ]]; then
    printMessage "Docker service is stopped."
    printMessage 'Starting docker service.' && sudo service docker start && printMessage 'Docker service started.'
else
    printMessage "Docker service is running."
fi
