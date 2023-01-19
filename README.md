# Samba LDAP User Creator
Create users and add them to groups from CSV file with the samba-tool command
---

## What do you need?
You will need a linux machine set up with samba-ldap and root access.

## How you do it:
1. Download the script with `wget` or the whole repo with the `git` command
2. Make the script executable with `chmod +x create-user.sh` for the user script or `chmod +x create-group.sh` for the group script
3. Run the script with either `./create-user.sh <path to csv-file>` for the user script or `./create-group.sh <path to csv-file>` for the group script.

## CSV formatting
Note that the seperators and order of columns can be changed in the script.
### groups CSV
```plaintext
oupath=OU=ou,OU=to,OU=path
group1
group2
...
```

### users CSV
Note that groups in this CSV must already exist, they will not be added if they don't exist!
```plaintext
oupath=OU=ou,OU=to,OU=path
username;name;surname;password;[groups,seperated,by,comma]
...
```
