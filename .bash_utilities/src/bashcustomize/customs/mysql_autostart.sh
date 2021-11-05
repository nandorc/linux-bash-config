#!/bin/bash

source ~/.bash_utilities/lib/messages.sh

if [ -z "$(ls -a /var/run | grep ^mysqld$)" ] || [ -z "$(ls -a /var/run/mysqld | grep ^mysqld.sock$)" ]; then
  printInfoMessage "MySQL service is stopped. Let's start it."
  sudo service mysql start && printInfoMessage "MySQL service started"
  sleep 2
fi
