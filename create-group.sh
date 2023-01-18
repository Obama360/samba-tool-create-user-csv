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
oupath=$(head -n 1 "$csvPath")
oupath=$(printf "%s\n" "${oupath//'oupath='}")
echo "$basedn"

while IFS= read -r group; do
  samba-tool group add $group && echo "created group $group" || echo "failed to create group $group"
done < "$csvPath"
