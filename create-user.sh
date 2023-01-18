#!/bin/bash

# Create AD Users with samba-tool command from csv file
# Created 2023-1
# Nico Braun

# CSV Template:
# ouPath=OU=Ou,OU=To,OU=Path
# username;name;surname;password;[groups,seperated,by,comma]
# ...

if [[ $1 == "" ]]; then
  echo "usage: ./create-user.sh [user-csv-path]"
  exit 0
fi

csvPath=$1
seperator=";"
seperatorGroups=","

#get basedn from first line
ouPath=$(head -n 1 "$csvPath")
ouPath=$(printf "%s\n" "${ouPath//'oupath='}")
echo "OU = $ouPath"

#process users
while IFS="$seperator" read -r username name surname password groups; do
  #get groups and put them into an array
  groups=$(echo $groups | sed 's/\[//g' | sed 's/\]//g') #change the [ & ] characters here if needed
  IFS="$seperatorGroups" read -r -a groups <<< "$groups"

  #create user
  sudo samba-tool user create "$username" "$password" --given-name="$name" --surname="$username" --userou="$ouPath" && echo "created user $username" || echo "failed to create user $username"

  #add user to groups
  for group in "${groups[@]}"; do
    samba-tool group addmembers $group $username && echo "added $username to group $group" || echo "failed to add $username to $group!"
  done
done < <(tail -n +2 "$csvPath")
