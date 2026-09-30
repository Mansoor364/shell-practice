#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/expense"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIME_STAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIME_STAMP.log"

mkdir -p $LOGS_FOLDER

ROOT(){
USERID=$(id -u)
if [ $USERID -ne 0 ]
then
    echo -e "please run the script with$R root privileges $N"   | tee -a $LOG_FILE
    exit 1
fi
}
ROOT

echo -e "script started executing at :$G $(date) $N"    | tee -a $LOG_FILE

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R FAILED..$N"          | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$2 is $G SUCCESS..$N"         | tee -a $LOG_FILE
	fi      
}

dnf install mysql-server -y                &>>$LOG_FILE
VALIDATE $? "Installing mysql-server"

systemctl enable mysqld                    &>>$LOG_FILE   
VALIDATE $? "Enabling mysql-server"

systemctl start mysqld                     &>>$LOG_FILE
VALIDATE $? "Starting mysql-server"

mysql -h 172.31.23.151 -u root -pExpenseApp@1 -e 'show databases;'  &>>$LOG_FILE      
if [ $? -ne 0 ]
then
    echo -e "mysql $R root password is not setted.. $N set it"           | tee -a $LOG_FILE 
    mysql_secure_installation --set-root-pass ExpenseApp@1          
    VALIDATE $? "mysql-server root password set-up"
else
    echo -e "mysql-server $G root password is already setted.. $N SKIP"    | tee -a $LOG_FILE
fi


