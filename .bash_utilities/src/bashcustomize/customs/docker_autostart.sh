#!/bin/bash

source ~/.bash_utilities/lib/messages.sh

if [[ "$(service docker status)" =~ "is not running" ]]; then
  printInfoMessage "Docker service is stopped. Let's start it."
  sudo service docker start && printInfoMessage "Docker service started"
fi