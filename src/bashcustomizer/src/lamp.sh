#!/bin/bash

source ~/.bash_utilities/src/bashcustomizer/lib/local/customshandler.sh
source ~/.bash_utilities/lib/ext/dsoft/messages.sh

includeCustomization apache
includeCustomization mysql

# LAMP Service
alias lamp_start="printInfoMessage 'Starting LAMP services.' before && webserver_start && mysql_start && printInfoMessage 'LAMP services running.' after"
alias lamp_stop="printInfoMessage 'Stopping LAMP services.' before && webserver_stop && mysql_stop && printInfoMessage 'LAMP services stopped.' after"
alias lamp_restart="printInfoMessage 'Restarting LAMP services.' before && webserver_restart && mysql_restart && printInfoMessage 'LAMP services restarted.' after"
