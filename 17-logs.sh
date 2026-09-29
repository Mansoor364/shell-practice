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

dnf list installed git
if [ $? -ne 0 ]
then
    echo "git is not installed, going to install it"
    dnf install git -y
    if [ $? -ne 0 ]
    then
        echo "installing git is failed., check it"
        exit 1
    else
        echo "git installation is successfull"
    fi
else
    echo "git is already installed.. nothing to do"
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo "mysql is not installed, going to install it"
    dnf install mysql -y
    if [ $? -ne 0 ]
    then
        echo "mysql installation failed, check it"
        exit 1
    else
        echo "mysql is installed sucessfully"
    fi
else
    echo "mysql is already installed, nothing to do"
fi