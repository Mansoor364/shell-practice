#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)   #id -u will give userid
ROOT_USER(){
    if [ $USERID -ne 0 ]
    then
        echo -e "$Yplease run script with$N $Rroot user privileges..$N"
        exit 1
    fi
}
ROOT_USER

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R Failed$N"
        exit 1
    else
        echo -e "$2 is $G SUCCESS$N"
    fi
}

for package in $@
do
    dnf list installed $package
    if [ $? -ne 0 ]
    then
        echo -e "$R$package$N is $Ynot installed, installing it..$N"
        dnf install $package -y
        VALIDATE $? "$package installation"
    else
        echo -e "$G$package $N is $Y already installted, nothing to do$N"
    fi
done

