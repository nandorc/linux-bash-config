#!/bin/bash

source ~/.bash_utilities/src/bashcustomize/data/manager.sh

includeCustomization lamp
includeCustomization elasticsearch

# Magento Commerce
alias magento_start="lamp_start && elasticsearch_start"
alias magento_stop="lamp_stop && elasticsearch_stop"
alias magento_restart="lamp_restart && elasticsearch_restart"