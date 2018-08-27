#!/bin/bash

# This script should run as superuser
if [[ ${UID} -ne 0 ]]
then
    echo "You should run this script as sudo"
    exit 1
fi

HOSTNAME=$(hostname)

read -p 'Enter username: ' USERNAME
read -p "Enter full name: " FULL_NAME
read -p "Enter password: " PASSWORD

useradd -c "${FULL_NAME}" -m ${USERNAME}

if [[ ${?} -ne 0 ]]
then
    echo "User could not be created!!!"
    exit 1
else
    echo "User created successfully!!!"
fi

# use the password entered above to set the password for the user
echo "Setting the user password!!"
echo ${PASSWORD} | passwd --stdin  ${USERNAME}

#expire the password on first login 
echo "Expiring the user password!!"
passwd -e ${USERNAME}

echo "User name is : ${USERNAME}"
echo "Full name is : ${FULL_NAME}"
echo "Password set : ${PASSWORD}"
echo "Hostname is : ${HOSTNAME}"
exit 0