#!/bin/bash

#instllating mysql, nginx, mongodb mongosh

USERID=$(id -u)
if [USERID -ne 0]; then 
  echo "Error: Please run the script with root priviliges"
  exit 1
fi


#Calling Function recieve inputs through args 
validate () {

if [$1 ne 0]; then 
  echo "Error: Installing $2 is failure"
  exit 1
  else
  echo "$2 installation is successfull.."


  }

dnf install mysql -y 
validate $? "MYSQL"

dnf install nginx -y 
validate $? "Nginx"

dnf install mongodb-mongosh -y
validate $? "mongodb-mongosh"



