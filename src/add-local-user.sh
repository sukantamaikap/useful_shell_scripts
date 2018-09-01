#!/bin/bash

# Script should be used with at least one 
REMAINDER=${#}%2
if [[ ${#} -le 1 ]] || [[ ${REMAINDER} -ne 0 ]]
then
    echo "There should be at least two parameter or even number of parameters passed to........ this scrip"
    echo
    echo "USAGE"
    echo "add-local-user username1 \"FirstName LastName\" [username2 \"FirstName LastName\"...]"
    echo
    echo "DESCRIPTION"
    echo "Creates users specified as parameters. The scrip expects username (8 character long by convention) and Full Name in the same order."
    exit 1
fi

# This script should run as superuser
if [[ ${UID} -ne 0 ]]
then
    echo "You should run this script as sudo"
    exit 1
fi


while [[ ${#} -ge 1 ]]
do
    echo "*****************************************"
    echo
    USERNAME=${1}
    echo "Username found : ${USERNAME}"

    FULL_NAME=${2}
    echo "Full name entered is : ${FULL_NAME}"

    echo "Generating password automatically!!"
    SPECIAL_CHARACTER1=$(echo "@#$%^&*()_|+=" | fold -w1 | shuf | head -c1)
    SPECIAL_CHARACTER2=$(echo "@#$%^&*()_|+=" | fold -w1 | shuf | head -c1)
    RANDOM_STRING=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c12)${SPECIAL_CHARACTER1}${SPECIAL_CHARACTER2}
    PASSWORD=$(echo "${RANDOM_STRING}" | shuf)
    
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
    shift 2
    echo
    echo "*****************************************"
done

HOSTNAME=$(hostname)
echo "Hostname is : ${HOSTNAME}"

exit 0