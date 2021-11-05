#!/bin/bash

# Apache webserver
webserver_path="/var/www"
alias webserver_path="cd $webserver_path"
alias webserver_start="sudo service apache2 start"
alias webserver_stop="sudo service apache2 stop"
alias webserver_restart="sudo service apache2 restart"

# Localhost
localhost_path="$webserver_path/html"
localhost_url="http://localhost"
alias localhost="explorer.exe $localhost_url"
alias localhost_path="cd $localhost_path"
