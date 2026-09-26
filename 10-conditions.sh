#!/bin/bash
#pass Num at run-time,Num>25 or N<25
Number=$1
if [ $Number -gt 25 ]
then
    echo "$Number is greater than 25"
else
    echo "$Number is less than 25"
fi
