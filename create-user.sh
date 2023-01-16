#!/bin/bash

# Create AD Users with samba-tool command from csv file
# Created 2023-1
# Nico Braun

#read -p "CSV File location: " csvPath
csvPath="users.txt"

while IFS= read -r line; do 
  if [[ "$line" == "basedn="* ]]; then
    basedn=$(printf "%s\n" "${line//'basedn='}")
    echo "$basedn"
  else
    echo "$line" > /dev/null
  fi
done < "$csvPath"
