#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=(id -u)
ROOT_CHECK(){
if [ $USERID -ne 0 ]
then
    echo -e "$Y please run the script with $N $R root user privileges $N"
    exit 1
fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$R $2 is Failed $N"
        exit 1
    else
        echo -e "$G $2 is Success $N"
    fi
}

dnf list installed git 
if [ $? -ne 0 ]
then
    echo -e "$Y git is not installed, installing $N"
    dnf install git -y 
    VALIDATE $? "git installation"
else
    echo -e "$Y git is already installed nothing to do $N"
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo -e "$Y mysql is not installed..$N $G installing it $N"
    dnf install mysql -y
    VALIDATE $? "mysql installation"
else
    echo -e "$Y mysql is already installed $N $G nothing to do..$N"
fi