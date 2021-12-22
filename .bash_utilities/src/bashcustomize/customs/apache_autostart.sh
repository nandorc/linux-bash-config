#!/bin/bash

source ~/.bash_utilities/lib/messages.sh

if [[ "$(service apache2 status)" =~ "is not running" ]]; then
  printInfoMessage "Apache service is stopped. Let's start it."
  sudo service apache2 start && printInfoMessage "Apache service started"
fi
