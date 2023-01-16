#!/bin/bash

# Create AD Users with samba-tool command from csv file
# Created 2023-1
# Nico Braun

csvPath=$1
seperator=";"
seperatorGroups=","

#get basedn from first line
basedn=$(head -n 1 "$csvPath")
basedn=$(printf "%s\n" "${basedn//'basedn='}")
echo "$basedn"

#process users
while IFS="$seperator" read -r username name surname password groups; do
  #get groups and put them into an array
  groups=$(echo $groups | sed 's/\[//g' | sed 's/\]//g')
  IFS="$seperatorGroups" read -r -a groups <<< "$groups"

  #create user
  echo "Username=$username, Password=$password, Groups=${groups[0]}"

  #add user to groups
  for group in "${groups[@]}"; do
    echo "$group"
  done
done < <(tail -n +2 "$csvPath")
