#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOUR_DIR=$1                       #user will provide dynamically source direct
DEST_DIR=$2                       #user will provide destination dir, as argument
DAYS=${3:-14}                     #Days is optional -if user doesnt provide 14 will be considered
TIME_STAMP=$(date +%Y-%m-%d-%H-%M-%S)

USAGE(){
    echo "USAGE:: sh 21-zip-move.sh source-dir destina-dir days"
    exit 1
}
if [ $# -lt 2 ]
then
    USAGE 
fi

if [ ! -d $SOUR_DIR ]
then
    echo "$SOUR_DIR doesn't exist please provide correct directory"
    exit 1
fi

if [ ! -d $DEST_DIR ]
then
    echo "$DEST_DIR doesn't exist please provide appropriate directory"
    exit 1
fi

FILES=$(find $SOUR_DIR -name "*.log" -mtime +$DAYS)
echo "log files older than $DAYS are : $FILES"

if [ ! -z $FILES ]
then
    echo "source files exist"
    ZIP_FILE="$DEST_DIR/app-log-$TIME_STAMP.zip"
    find $SOUR_DIR -name "*.log" -mtime +$DAYS | zip $ZIP_FILE -@
    if [ -f $ZIP_FILE ]
    then
        echo "log files older than $DAYS are Zipped sucessfuly"
        while IFS= read -r file
        do
            echo "deleting files : $file
            rm -rf $file
        done<<<$FILES
    else
        echo "Zipping log files older than $DAYS is failed"
    fi          
else
    echo "log files older than $DAYS not exist"
fi
