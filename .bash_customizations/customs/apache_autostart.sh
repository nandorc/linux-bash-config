#!/bin/bash

source ~/.bash_customizations/utils/messages.sh

if [[ "$(service apache2 status)" =~ "is not running" ]]; then
  printInfoMessage "Apache service is stopped. Let's start it."
  sudo service apache2 start && printInfoMessage "Apache service startted"
  sleep 2
fi
