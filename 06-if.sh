#!/usr/bin/env bash

name=$1

if [ "$name" == "DevOps" ]; then
  echo Yes, $1 is Available
else
  echo No, $1 is Not Available
fi
