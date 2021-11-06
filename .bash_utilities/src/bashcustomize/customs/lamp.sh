#!/bin/bash

source ~/.bash_utilities/src/bashcustomize/data/manager.sh

includeCustomization apache
includeCustomization mysql

# LAMP Service
alias lamp_start="webserver_start && mysql_start"
alias lamp_stop="webserver_stop && mysql_stop"
alias lamp_restart="webserver_restart && mysql_restart"