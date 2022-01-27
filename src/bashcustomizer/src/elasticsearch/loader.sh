#!/bin/bash

# Dependencies
source ~/.bash_utilities/src/bashcustomizer/lib/local/executor.sh

# Load aliases
wrapFileInclusion "Including elasticsearch aliases..." "~/.bash_utilities/src/bashcustomizer/src/elasticsearch/aliases.sh"
