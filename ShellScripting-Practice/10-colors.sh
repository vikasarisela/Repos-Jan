#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo -e "$G Hello World $N"

#!/bin/bash

#instllating mysql, nginx, mongodb mongosh

USERID=$(id -u)
if [USERID -ne 0]; then 
  echo "Error: Please run the script with root priviliges"
  exit 1
fi

#if 0 already installed mysql
dnf list installed mysql
if [$? -ne 0]; then
dnf install mysql -y 
validate $? "MYSQL"
else 
echo "MYSQL already exists .... $G Skipping $N"



dnf list installed nginx
if [$? -ne 0]; then
dnf install nginx -y 
validate $? "NGINX"
else 
echo "NGINX already exists .... $G Skipping $N"


dnf list installed mongodb-mongosh
if [$? -ne 0]; then
dnf install mongodb-mongosh -y 
validate $? "mongodb-mongosh"
else 
echo "mongodb-mongosh already exists .... $G Skipping $N"



#Calling Function recieve inputs through args 
validate () {
if [$1 -ne 0]; then 
  echo -e "Error: Installing $2 is $R FAILURE $N"
  exit 1
  else
  echo -e "$2 installation is $G SUCCESSFUL $N.."
  }


