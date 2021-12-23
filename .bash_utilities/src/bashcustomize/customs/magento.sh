#!/bin/bash

source ~/.bash_utilities/src/bashcustomize/data/manager.sh
source ~/.bash_utilities/lib/messages.sh

includeCustomization lamp
includeCustomization elasticsearch

# Magento Commerce
alias magento_start="printInfoMessage 'Starting Magento services.' before && lamp_start && elasticsearch_start && printInfoMessage 'Magento services running.' after"
alias magento_stop="printInfoMessage 'Stopping Magento services.' before && lamp_stop && elasticsearch_stop && printInfoMessage 'Magento services stopped.' after"
alias magento_restart="printInfoMessage 'Restarting Magento services.' before && lamp_restart && elasticsearch_restart && printInfoMessage 'Magento services restarted.' after"