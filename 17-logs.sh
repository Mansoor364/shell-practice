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

dnf list installed git
if [ $? -ne 0 ]
then
    echo "git is not installed, going to install it"
    dnf install git -y
    VALIDATE $? "git installation"
else
    echo "git is already installed.. nothing to do"
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo "mysql is not installed, going to install it"
    dnf install mysql -y
    VALIDATE $? "mysql installation"
else
    echo "mysql is already installed, nothing to do"
fi