#!/bin/bash

# Dependencies
source ~/.basher/src/bashcustomizer/lib/local/executor.sh
source ~/.basher/src/bashcustomizer/lib/local/customshandler.sh

# Included customizations
includeCustomization apache
includeCustomization mysql

# Load aliases
wrapFileInclusion "Including lamp aliases..." "~/.basher/src/bashcustomizer/src/lamp/aliases.sh"
