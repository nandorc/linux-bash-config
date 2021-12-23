#!/bin/bash

source ~/.bash_utilities/lib/messages.sh

printInfoMessage "Checking apache service..."
if [[ "$(service apache2 status)" =~ "is not running" ]]; then
  printInfoMessage "Apache service is stopped."
  printInfoMessage 'Starting apache service.' && sudo service apache2 start && printInfoMessage 'Apache service started.'
else
  printInfoMessage "Apache service is running."
fi
