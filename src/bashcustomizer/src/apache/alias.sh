#!/bin/bash

alias webserver="cd $webserver_path"
alias webserver_start="printInfoMessage 'Starting apache service.' before && sudo service apache2 start && printInfoMessage 'Apache service started.' after"
alias webserver_stop="printInfoMessage 'Stopping apache service.' before && sudo service apache2 stop && printInfoMessage 'Apache service stopped.' after"
alias webserver_restart="printInfoMessage 'Restarting apache service.' before && sudo service apache2 restart && printInfoMessage 'Apache service restarted.' after"