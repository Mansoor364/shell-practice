#!/bin/bash
#pass minimum of two arguments/values to script in run-time

#Print all variables passed to script at run-time 
echo "All values passed to script are: $@ "

#Print Number of values passed to script at runtime
echo "Total number of values passed to script $#"

#Print name of currently executed file
echo "Name of current executed file $0"

#To get Current working file path
echo "Currently working in path $PWD"

#Print Home directory of user logged in
echo "Currently logged user home directory $HOME"

#Process Instance Id of last executed file
echo "PID of last executed file $$"

#Process Instance Id of last executed background command
sleep 100&
echo "PID of last executed command $!"