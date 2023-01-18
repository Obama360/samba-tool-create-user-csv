#!/bin/bash

# Create AD Groups with samba-tool command from csv file
# Created 2023-1
# Nico Braun

# CSV Template:
# oupath=OU=ou,OU=pathto
# group1
# group2
# ...

if [[ $1 == "" ]]; then
  echo "usage: ./create-group.sh [group-csv-path]"
  exit 0
fi

csvPath=$1

#get ou from first line
ouPath=$(head -n 1 "$csvPath")
ouPath=$(printf "%s\n" "${ouPath//'oupath='}")
echo "OU = $ouPath"

while IFS= read -r group; do
  samba-tool group add $group --groupou="$ouPath" && echo "created group $group" || echo "failed to create group $group"
done < <(tail -n +2 "$csvPath")
