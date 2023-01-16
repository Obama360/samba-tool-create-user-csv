#!/bin/bash

# Create AD Users with samba-tool command from csv file
# Created 2023-1
# Nico Braun

#read -p "CSV File location: " csvPath
csvPath=$1
seperatorNormal=";"

#get basedn from first line
basedn=$(head -n 1 "$csvPath")
basedn=$(printf "%s\n" "${basedn//'basedn='}")
echo "$basedn"

#rest of file
while IFS="$seperatorNormal" read -r username name surname password groups; do
  groups=$(echo $groups | sed 's/\[//g' | sed 's/\]//g')
  echo "Username=$username, Password=$password, Groups=$groups"
done < <(tail -n +2 "$csvPath")
