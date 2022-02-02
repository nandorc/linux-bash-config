#!/bin/bash

# Dependencies
source ~/.basher/src/bashcustomizer/src/magento/commands.sh
source ~/.basher/src/bashcustomizer/lib/local/executor.sh

# Magento Commerce
alias bc:magento:start="wrapCommand --colored 'Starting Magento services...' 'startMagentoServices' both"
alias bc:magento:stop="wrapCommand --colored 'Stopping Magento services...' 'stopMagentoServices' both"
alias bc:magento:restart="wrapCommand --colored 'Restarting Magento services...' 'restartMagentoServices' both"
