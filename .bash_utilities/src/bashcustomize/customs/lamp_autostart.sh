#!/bin/bash

source ~/.bash_utilities/src/bashcustomize/data/manager.sh
source ~/.bash_utilities/lib/messages.sh

printInfoMessage "Checking LAMP services..."
includeCustomization apache_autostart
includeCustomization mysql_autostart
printInfoMessage "LAMP services running."
