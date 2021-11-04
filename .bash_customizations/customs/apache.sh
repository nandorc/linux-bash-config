#!/bin/bash

# Apache webserver
webserver_path="/var/www"
alias webserver_path="cd $webserver_path"

# Localhost
localhost_path="$webserver_path/html"
localhost_url="http://localhost"
alias localhost="explorer.exe $localhost_url"
alias localhost_path="cd $localhost_path"
