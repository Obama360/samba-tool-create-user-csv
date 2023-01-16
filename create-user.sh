#!/bin/bash

# Create AD Users with samba-tool command from csv file
# Created 2023-1
# Nico Braun

read -p "CSV File location: " csvPath

while IFS= read -r line; do 
  if [[ "$line" == "basedn="* ]]; then
    echo "judihui geisschäs!"
  else
    echo "$line"
  fi
done < "$csvPath"
