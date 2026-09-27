#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)

ROOT_CHECK(){
if [ $USERID -ne 0 ]
then
    echo -e " $R get root user access $N "
    exit 1
fi
}
ROOT_CHECK

VALIDATE(){
    if [ $1 -ne 0 ]      #exit status of dnf install git/mysql is not 0
    then
        echo -e "$2 is $R FAILED $N"
        exit 1
    else
        echo -e "$2 is $G SUCCESS $N"
    fi
}

dnf list installed git
if [ $? -ne 0 ]
then
    echo -e "$Y git is not installed, install it $N"
    dnf install git -y 
    VALIDATE $? "Git installation"
else
    echo -e "$Y git is already installed nothing to do $N"
fi

dnf list installed mysql 
if [ $? -ne 0 ]
then
    echo -e "$Y mysql is not installed,installing it $N"
    dnf install mysql -y
    VALIDATE $? "Mysql Installation"
else
    echo "$Y mysql is already installed, nothing to do.. $N"
fi