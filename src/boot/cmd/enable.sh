#!/bin/bash

# Dependencies
source ~/.basher/lib/messages.sh

# Check features.ini file
if [ ! -f ~/.basher/src/boot/etc/features.ini ]; then
    printWarningMessage "features.ini not set" before
    basher boot:reset
fi
