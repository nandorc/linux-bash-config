#!/bin/bash

# Dependencies
source ~/.bash_utilities/src/bashcustomizer/lib/local/executor.sh
source ~/.bash_utilities/src/bashcustomizer/lib/local/customshandler.sh

# Included customizations
includeCustomization apache
includeCustomization mysql

# Load aliases
wrapFileInclusion "Including lamp aliases..." "~/.bash_utilities/src/bashcustomizer/src/lamp/aliases.sh"
