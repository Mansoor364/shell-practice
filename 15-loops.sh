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

for package in $@
do
    dnf list installed $package
    if [ $? -ne 0 ]
    then
        echo -e "$Y $package is installing.... $N"
        dnf install $package -y
        if [ $? -ne 0 ]
        then
            echo -e "$R $package installation is failed $N"
            exit 1
        else
            echo -e "$G $package installation is success $N"
        fi
    else
        echo -e "$Y $package is already installated.. nothing to do $N"
    fi
done

