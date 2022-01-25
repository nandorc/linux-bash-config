#!/bin/bash

source ~/.bash_utilities/lib/ext/dsoft/messages.sh

printMessage "Checking apache service..."
if [[ "$(service apache2 status)" =~ "is not running" ]]; then
    printMessage "Apache service is stopped."
    printMessage 'Starting apache service.' && sudo service apache2 start && printMessage 'Apache service started.'
else
    printMessage "Apache service is running."
fi
