#!/bin/bash

# Dependencies
source ~/.bash_utilities/src/bashcustomizer/lib/local/executor.sh

# Load variables
wrapFileInclusion "Including apache variables..." "~/.bash_utilities/src/bashcustomizer/src/apache/variables.sh"
# Load aliases
wrapFileInclusion "Including apache aliases..." "~/.bash_utilities/src/bashcustomizer/src/apache/aliases.sh"
