#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIRECTORY="/home/ec2-user/log"          #at which directory log files are present
if [ -d $SOURCE_DIRECTORY ]                    #WHETHER directory exists or not
then
    echo -e "$SOURCE_DIRECTORY $G exists $N"
else
    echo -e "$SOURCE_DIRECTORY $R not exists $N"
    exit 1
fi

FILES=$(find $SOURCE_DIRECTORY -name "*.log" -mtime +14)
echo -e "LOG FILES are :$Y $FILES $N"

while IFS= read -r file
do
    echo "deleting file : $file"
    rm -rf $file
done<<<$FILES
