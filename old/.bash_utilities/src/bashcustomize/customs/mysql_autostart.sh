#!/bin/bash

source ~/.bash_utilities/lib/messages.sh

printInfoMessage "Checking mysql service..."
if [ -z "$(ls -a /var/run | grep ^mysqld$)" ] || [ -z "$(ls -a /var/run/mysqld | grep ^mysqld.sock$)" ]; then
  printInfoMessage "MySQL service is stopped."
  printInfoMessage 'Starting mysql service.' && sudo service mysql start && printInfoMessage "MySQL service started."
else
  printInfoMessage "MySQL service is running."
fi
