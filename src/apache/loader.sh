#!/bin/bash

# Dependencies
source ~/.basher/src/bashcustomizer/lib/local/executor.sh

# Load variables
wrapFileInclusion "Including apache variables..." "~/.basher/src/bashcustomizer/src/apache/variables.sh"
# Load aliases
wrapFileInclusion "Including apache aliases..." "~/.basher/src/bashcustomizer/src/apache/aliases.sh"
