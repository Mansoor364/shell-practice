#!/bin/bash

CHECK_ROOT(){
USERID=$(id -u)   #checking user id of user running script should be 0 fr root
if [ $USERID -ne 0 ]
then
    echo "please run this script with root user privilege"
    exit 1         #shell script dont stops
fi
}
CHECK_ROOT

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 is FAILED"
        exit 1
    else
        echo "$2 is SUCCESSFULL"
    fi
}


for package in $@
do
    dnf list installed $package
    if [ $? -ne 0 ]
    then
        echo "$package is not installed, going to install it"
        dnf install $package -y
        VALIDATE $? "$package installation"
    else
        echo "$package is already installed.. nothing to do"
    fi
done
