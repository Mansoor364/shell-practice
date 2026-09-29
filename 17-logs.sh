#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

CHECK_ROOT(){
USERID=$(id -u)   #checking user id of user running script should be 0 fr root
if [ $USERID -ne 0 ]
then
    echo -e "$Y please run this script$N $R with root user privilege$N"
    exit 1         #shell script dont stops
fi
}
CHECK_ROOT

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$Y $2 $N $R is FAILED$N"
        exit 1
    else
        echo -e "$Y $2 $N $G is SUCCESSFULL$N"
    fi
}


for package in $@
do
    dnf list installed $package
    if [ $? -ne 0 ]
    then
        echo -e "$Y $package is not installed,$N $G going to install it $N"
        dnf install $package -y
        VALIDATE $? "$package installation"
    else
        echo -e "$G $package is already installed.. nothing to do $N"
    fi
done
