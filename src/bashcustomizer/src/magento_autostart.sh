#!/bin/bash

source ~/.bash_utilities/src/bashcustomizer/lib/local/customshandler.sh
source ~/.bash_utilities/lib/ext/dsoft/messages.sh

printMessage "Checking Magento services..."
includeCustomization lamp_autostart
includeCustomization elasticsearch_autostart
printMessage "Magento services running."
