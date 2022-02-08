#!/bin/bash

# Dependencies
source ~/.basher/lib/messages.sh

printInfoMessage "Setting elasticsearch path..." before
if [ -z "$1" ] || [ ! -f "$1"/bin/elasticsearch ]; then
    printWarningMessage " * No valid elasticsearch path given. Try again" after
else
    rm -f ~/.basher/src/elasticsearch/var/path && touch ~/.basher/src/elasticsearch/var/path
    echo $1 >>~/.basher/src/elasticsearch/var/path
    printMessage " * root path for elasticsearch setted" after
fi
