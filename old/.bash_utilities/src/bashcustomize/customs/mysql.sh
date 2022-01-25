#!/bin/bash

source ~/.bash_utilities/lib/messages.sh

# MySQL service
alias mysql_start="printInfoMessage 'Starting mysql service.' before && sudo service mysql start && printInfoMessage 'MySQL service started.' after"
alias mysql_stop="printInfoMessage 'Stopping mysql service.' before && sudo service mysql stop && printInfoMessage 'MySQL service stopped.' after"
alias mysql_restart="printInfoMessage 'Restarting mysql service.' before && sudo service mysql restart && printInfoMessage 'MySQL service restarted.' after"
