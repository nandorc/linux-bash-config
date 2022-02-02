#!/bin/bash

# Dependencies
source ~/.basher/src/bashcustomizer/lib/local/executor.sh

# Load aliases
wrapFileInclusion "Including elasticsearch aliases..." "~/.basher/src/bashcustomizer/src/elasticsearch/aliases.sh"
