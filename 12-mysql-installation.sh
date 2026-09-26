#!/bin/bash
#check user has root access or not

USERID=$(id -u)
if [ $USERID -ne 0 ]
then
    echo "get root user access.."
    exit 1
fi

#check mysql is installed or not
dnf list installed mysql
if [ $? -ne 0 ]
then 
    echo "Mysql is not installed, install it"
    dnf install mysql -y
    if [ $? -ne 0 ]
    then
        echo "mysql is not installed, check it."
        exit 1
    else
        echo "Mysql is installed.."
else
    echo "Mysql is already installed, nothing to do.."