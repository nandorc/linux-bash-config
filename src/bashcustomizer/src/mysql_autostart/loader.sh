#!/bin/bash

# Load dependencies
source ~/.basher/lib/messages.sh
source ~/.basher/src/bashcustomizer/lib/local/executor.sh

# Check and load mysql service
printMessage "Checking mysql service..."
if [ -z "$(ls -a /var/run | grep ^mysqld$)" ] || [ -z "$(ls -a /var/run/mysqld | grep ^mysqld.sock$)" ]; then
    wrapCommand 'Starting mysql service...' 'sudo service mysql start'
else
    printMessage "done"
fi
