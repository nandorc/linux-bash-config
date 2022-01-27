#!/bin/bash

# Dependencies
source ~/.bash_utilities/src/bashcustomizer/src/lamp/commands.sh
source ~/.bash_utilities/src/bashcustomizer/lib/local/executor.sh

# LAMP Service
alias bc:lamp:start="wrapCommand --colored 'Starting LAMP services...' 'startLampServices' both"
alias bc:lamp:stop="wrapCommand --colored 'Stopping LAMP services...' 'stopLampServices' both"
alias bc:lamp:restart="wrapCommand --colored 'Restarting LAMP services...' 'restartLampServices' both"
