#!/bin/bash

source ~/.bash_utilities/src/bashcustomizer/lib/local/customshandler.sh
source ~/.bash_utilities/lib/ext/dsoft/messages.sh

printMessage "Checking LAMP services..."
includeCustomization apache_autostart
includeCustomization mysql_autostart
printMessage "LAMP services running."
