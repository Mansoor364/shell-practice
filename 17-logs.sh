#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIME_STAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIME_STAMP.log"
mkdir -p $LOGS_FOLDER

CHECK_ROOT(){
USERID=$(id -u)   #checking user id of user running script should be 0 fr root
if [ $USERID -ne 0 ]
then
    echo -e "$Y please run this script$N $R with root user privilege$N" | tee -a $LOG_FILE
    exit 1         #shell script dont stops
fi
}
CHECK_ROOT

USAGE(){
    echo -e "$R USAGE:: sudo sh logs.sh package1 package2.....$N" | tee -a $LOG_FILE
    exit 1
}
if [ $# -eq 0 ]
then
    USAGE
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$Y $2$N $R is FAILED$N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$Y $2$N $G is SUCCESSFULL$N" | tee -a $LOG_FILE
    fi
}

for package in $@
do
    dnf list installed $package   &>>$LOG_FILE
    if [ $? -ne 0 ]
    then
        echo -e "$Y $package is not installed,$N $G going to install it $N" | tee -a $LOG_FILE
        dnf install $package -y  &>>$LOG_FILE
        VALIDATE $? "$package installation"  
    else
        echo -e "$G $package is already installed.. nothing to do $N"  | tee -a $LOG_FILE
    fi
done
