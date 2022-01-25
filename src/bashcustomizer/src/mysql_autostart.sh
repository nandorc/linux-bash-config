#!/bin/bash

source ~/.bash_utilities/lib/ext/dsoft/messages.sh

printMessage "Checking mysql service..."
if [ -z "$(ls -a /var/run | grep ^mysqld$)" ] || [ -z "$(ls -a /var/run/mysqld | grep ^mysqld.sock$)" ]; then
    printMessage "MySQL service is stopped."
    printMessage 'Starting mysql service.' && sudo service mysql start && printMessage "MySQL service started."
else
    printMessage "MySQL service is running."
fi
