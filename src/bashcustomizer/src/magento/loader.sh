#!/bin/bash

# Dependencies
source ~/.bash_utilities/src/bashcustomizer/lib/local/executor.sh
source ~/.bash_utilities/src/bashcustomizer/lib/local/customshandler.sh

# Included customizations
includeCustomization lamp
includeCustomization elasticsearch

# Load aliases
wrapFileInclusion "Including magento aliases..." "~/.bash_utilities/src/bashcustomizer/src/magento/aliases.sh"
