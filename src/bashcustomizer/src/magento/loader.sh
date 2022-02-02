#!/bin/bash

# Dependencies
source ~/.basher/src/bashcustomizer/lib/local/executor.sh
source ~/.basher/src/bashcustomizer/lib/local/customshandler.sh

# Included customizations
includeCustomization lamp
includeCustomization elasticsearch

# Load aliases
wrapFileInclusion "Including magento aliases..." "~/.basher/src/bashcustomizer/src/magento/aliases.sh"
