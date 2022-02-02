#!/bin/bash

# Dependencies
source ~/.basher/src/bashcustomizer/src/lamp/commands.sh
source ~/.basher/src/bashcustomizer/lib/local/executor.sh

# LAMP Service
alias bc:lamp:start="wrapCommand --colored 'Starting LAMP services...' 'startLampServices' both"
alias bc:lamp:stop="wrapCommand --colored 'Stopping LAMP services...' 'stopLampServices' both"
alias bc:lamp:restart="wrapCommand --colored 'Restarting LAMP services...' 'restartLampServices' both"
