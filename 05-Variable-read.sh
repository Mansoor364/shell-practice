#!/bin/bash

#In this script we hide username and password and show entered username&pass
#Hiding Username &Password while entering &showing them on Terminal.

echo "Enter your Username"
read -s Username
echo "Entered name is::${Username}"
echo "Enter your password"
read -s password
echo "Your password is $password"
