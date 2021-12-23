#!/bin/bash

source ~/.bash_utilities/lib/messages.sh

printInfoMessage "Checking docker service..."
if [[ "$(service docker status)" =~ "is not running" ]]; then
  printInfoMessage "Docker service is stopped."
  printInfoMessage 'Starting docker service.' && sudo service docker start && printInfoMessage 'Docker service started.'
else
  printInfoMessage "Docker service is running."
fi
