#! /usr/bin/bash
# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
# Function for each requirement
#Length – minimum of 10 characters.
function password_length()
 {
    PWD_LENGTH=$(echo $1 | wc -c)
    if [ $PWD_LENGTH -lt 11 ]
        then
            echo -e "${RED}Password length is less than 10 characters"
            return 1
    fi
 }

#Check if value Contain digits
function password_contains_digits()
 {
    if ! [[ $1 =~ [0-9] ]]
    then 
       echo -e "${RED}Password does NOT contain digits"
       return 1
    fi
 }

#Check if value contain small letters
function password_contains_small_letters()
 {
     #for some reason the validation of [a-z] is not working properly. Using the ugly way...
    if ! [[ $1 =~ [abcdefghijklmnopqrstuvwxyz] ]]
    then 
       echo -e "${RED}Password does NOT contain small letters"
       return 1
    fi
 }

#Check if value contain capital letters
function password_contains_capital_letters()
 {
    if ! [[ $1 =~ [ABCDEFGHIJKLMNOPQRSTUVWXYZ] ]]
    then 
       echo -e "${RED}Password does NOT contain capital letters"
       return 1
    fi
 }

# Password validator: run each test and check the return value.
# If none fails, return OK and exit with 0, else return 1


if [ $# -eq 1 ] 
then
# Read password from input
   PASSWORD=$1
elif  [ $# -eq 2 ] &&  [ "$1" == "-f" ]
then
# Read passowrd from file
      read -r PASSWORD<$2
else
   echo -e "${RED}Illegal usage of flags / paramters"
   exit 1    
fi

password_length $PASSWORD
RET_LEN=$?
password_contains_digits $PASSWORD
RET_DIG=$?
password_contains_small_letters $PASSWORD
RET_SML=$?
password_contains_capital_letters $PASSWORD
RET_CAP=$?
if [ $RET_LEN -eq 0 ] &&  [ $RET_SML -eq 0 ] &&  [ $RET_CAP -eq 0 ]  &&  [ $RET_DIG -eq 0 ]
then
    echo -e "${GREEN}Your password is valid"
    exit 0
else
    exit 1
fi
