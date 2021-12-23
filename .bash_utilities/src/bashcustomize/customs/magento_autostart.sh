#!/bin/bash

source ~/.bash_utilities/src/bashcustomize/data/manager.sh
source ~/.bash_utilities/lib/messages.sh

printInfoMessage "Checking Magento services..."
includeCustomization lamp_autostart
includeCustomization elasticsearch_autostart
printInfoMessage "Magento services running."
