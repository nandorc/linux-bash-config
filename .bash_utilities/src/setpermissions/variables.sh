#!/bin/bash

while [ -n "$1" ]; do
  case "$1" in
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
