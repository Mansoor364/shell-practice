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
    echo -e "$R USAGE:: $N sh 21-zip-move.sh source-dir destina-dir days"
    exit 1
}
if [ $# -lt 2 ]
then
    USAGE 
fi

if [ ! -d $SOUR_DIR ]
then
    echo -e "$SOUR_DIR $R doesn't exist $N  $Y please provide correct directory$N"
    exit 1
fi

if [ ! -d $DEST_DIR ]
then
    echo -e "$DEST_DIR $R doesn't exist $N $R please provide appropriate directory$N"
    exit 1
fi

FILES=$(find $SOUR_DIR -name "*.log" -mtime +$DAYS)
echo -e "$Y log files older than $DAYS are $N : $FILES"

if [ ! -z $FILES ]
then
    echo -e "$G source files exist $N"
    ZIP_FILE="$DEST_DIR/app-log-$TIME_STAMP.zip"
    find $SOUR_DIR -name "*.log" -mtime +$DAYS | zip $ZIP_FILE -@
    if [ -f $ZIP_FILE ]
    then
        echo -e "log files older than $DAYS are $G Zipped sucessfuly $N"
        while IFS= read -r file
        do
            echo -e "$R deleting files :$N $file
            rm -rf $file
        done<<<$FILES
    else
        echo -e "Zipping log files older than $DAYS is $R failed $N"
    fi          
else
    echo -e "log files $R older than $DAYS not exist $N"
fi
