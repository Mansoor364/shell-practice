#!/bin/bash

#we get user id of user by using command id -u
USERID=$(id -u)
if [ $USERID -ne 0 ]                   #-eq,-ne,-gt,-lt,-ge,-le
then
    echo "Please run this script with root privileges"
    exit 1
fi

dnf list installed git          #checking git is installed or not
if [ $? -ne 0 ]                 #$? will give exit status of last executed command
then
    echo "git is not installed, install it"
    dnf install git -y          #installing git
    if [ $? -ne 0 ]
    then 
        echo "git is not installed, check it"
        exit 1
    else
        echo "git is installed.."
    fi
else
    echo "git is already installed, nothing to do.."
fi





