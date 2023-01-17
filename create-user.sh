#!/bin/bash

# Create AD Users with samba-tool command from csv file
# Created 2023-1
# Nico Braun

# CSV Template:
# basedn=OU=Ou,OU=To,OU=Path,DC=domain,DC=name
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
basedn=$(head -n 1 "$csvPath")
basedn=$(printf "%s\n" "${basedn//'basedn='}")
echo "$basedn"

#process users
while IFS="$seperator" read -r username name surname password groups; do
  #get groups and put them into an array
  groups=$(echo $groups | sed 's/\[//g' | sed 's/\]//g') #change the [ & ] characters here if needed
  IFS="$seperatorGroups" read -r -a groups <<< "$groups"

  #create user
  samba-tool user add "$username" "$password" --base-dn="$basedn" --given-name="$name" --surname="$surname" --display-name="$name $surname" -samaccountname="$username" && echo "created user $username" || echo "failed to create user $username"

  #add user to groups
  for group in "${groups[@]}"; do
    samba-tool group addmembers $group $username && echo "added $username to group $group" || echo "failed to add $username to $group!"
  done
done < <(tail -n +2 "$csvPath")
