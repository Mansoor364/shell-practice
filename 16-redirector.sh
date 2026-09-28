#!/bin/bash

USERID=$(id -u)   #id -u will give userid
ROOT_USER (){
    if [ $? -ne 0 ]
    then
        echo "please run script with root user privileges.."
        exit 1
    fi
}
ROOT_USER()

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 is Failed"
        exit 1
    else
        echo "$2 is SUCCESS"
    fi
}

for package in $@
do
    dnf list installed $package
    if [ $? -ne 0 ]
    then
        echo "$package is not installed, installing it.."
        dnf install $package -y
        VALIDATE()
    else
        echo "$package is already installted, nothing to do"
    fi
done

