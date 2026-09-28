#!/bin/bash
LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIME_STAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIME_STAMP.log"
mkdir -p $LOGS_FOLDER

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)   #id -u will give userid
ROOT_USER(){
    if [ $USERID -ne 0 ]
    then
        echo -e "$R please run script with root user privileges..$N" &>>$LOG_FILE
        exit 1
    fi
}

ROOT_USER
USAGE(){
    echo -e "$R USAGE:: sudo sh 16-redirector.sh package1 package2 $N"  &>>$LOG_FILE
    exit 1
}

echo "script started executing at .. $(date)"

if [ $# -eq 0 ]
then
    USAGE
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R Failed$N"   &>>$LOG_FILE
        exit 1
    else
        echo -e "$2 is $G SUCCESS$N"  &>>$LOG_FILE
    fi
}


for package in $@
do
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]
    then
        echo -e "$R$package $N is $Y not installed, installing it..$N"  &>>$LOG_FILE
        dnf install $package -y   &>>$LOG_FILE
        VALIDATE $? "$package installation"
    else
        echo -e "$G$package $N is $Y already installted, nothing to do$N"  &>>$LOG_FILE
    fi
done

