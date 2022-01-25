#!/bin/bash

source ~/.bash_utilities/lib/ext/dsoft/messages.sh

# Apache webserver
webserver_path="/var/www"
alias webserver_path="cd $webserver_path"
alias webserver_start="printInfoMessage 'Starting apache service.' before && sudo service apache2 start && printInfoMessage 'Apache service started.' after"
alias webserver_stop="printInfoMessage 'Stopping apache service.' before && sudo service apache2 stop && printInfoMessage 'Apache service stopped.' after"
alias webserver_restart="printInfoMessage 'Restarting apache service.' before && sudo service apache2 restart && printInfoMessage 'Apache service restarted.' after"

# Localhost
localhost_path="$webserver_path/html"
localhost_url="http://localhost"
alias localhost="explorer.exe $localhost_url"
alias localhost_path="cd $localhost_path"
