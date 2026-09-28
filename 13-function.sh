#!/bin/bash
USERID=$(id -u)                 #id -u command will give user id of user
if [ $USERID -ne 0 ]            #if user is not root user
then
    echo "run the script with root user access.."
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]     #exit status of dnf install git/mysql is not 0
    then
        echo "$2 is FAILED"    #git/mysql installation
        exit 1
    else
        echo "$2 is SUCCESS"    #git/mysql installation
    fi
}

dnf list installed git         
if [ $? -ne 0 ]   #if git is not installed
then 
    echo "git is not installed, installing git"
    dnf install git -y
    VALIDATE $? "Git installation"
else
    echo "git is already installed.. nothing to do"
fi

dnf list installed mysql
if [ $? -ne 0 ]      #mysql is not installed, install it
then
    echo "mysql is not installed, installing"
    dnf install mysql -y
    VALIDATE $? "Mysql installation"
else
    echo "mysql is already installed.. nothing to do"
fi