#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER=/var/log/shellscripting-logs
SCRIPT_NAME=$( echo $0 | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"

mdkir -p $LOG_FOLDER
echo "script started executed at $(date)"  | tee -a $LOG_FILE



USERID=$(id -u)
if [USERID -ne 0]; then 
  echo "Error: Please run the script with root priviliges"
  exit 1
fi

dnf list installed mysql &>>$LOG_FILE
if [$? -ne 0]; then
dnf install mysql -y  &>>$LOG_FILE
validate $? "MYSQL"
else 
echo "MYSQL already exists .... $G Skipping $N"   | tee -a $LOG_FILE



dnf list installed nginx &>>$LOG_FILE
if [$? -ne 0]; then
dnf install nginx -y &>>$LOG_FILE
validate $? "NGINX"
else 
echo "NGINX already exists .... $G Skipping $N" | tee -a $LOG_FILE



dnf list installed mongodb-mongosh &>>$LOG_FILE
if [$? -ne 0]; then
dnf install mongodb-mongosh -y &>>$LOG_FILE
validate $? "mongodb-mongosh"
else 
echo "mongodb-mongosh already exists .... $G Skipping $N" | tee -a $LOG_FILE


#Calling Function recieve inputs through args 
validate () {
if [$1 -ne 0]; then 
  echo -e "Error: Installing $2 is $R FAILURE $N"  | tee -a $LOG_FILE
  exit 1
  else
  echo -e "$2 installation is $G SUCCESSFUL $N.." | tee -a $LOG_FILE
  }


