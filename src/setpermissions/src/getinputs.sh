#!/bin/bash

showhelp=0
while [ -n "$1" ]; do
    case "$1" in
    -h)
        showhelp=1
        ;;
    -owner)
        ownername="$2"
        shift
        ;;
    -group)
        groupname="$2"
        shift
        ;;
    -file)
        filperm="$2"
        shift
        ;;
    -folder)
        dirperm="$2"
        shift
        ;;
    -exe)
        exeperm="$2"
        shift
        ;;
    --)
        shift
        break
        ;;
    *)
        path="$1"
        break
        ;;
    esac
    shift
done

# Set default values if necessary
[ -z "$exeperm" ] && exeperm=0774
[ -z "$filperm" ] && filperm=0664
[ -z "$dirperm" ] && dirperm=2775
