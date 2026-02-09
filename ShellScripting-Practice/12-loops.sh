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


#Calling Function recieve inputs through args 
validate () {
if [$1 -ne 0]; then 
  echo -e "Error: Installing $2 is $R FAILURE $N"  | tee -a $LOG_FILE
  exit 1
  else
  echo -e "$2 installation is $G SUCCESSFUL $N.." | tee -a $LOG_FILE
  }


USERID=$(id -u)
if [USERID -ne 0]; then 
  echo "Error: Please run the script with root priviliges"
  exit 1
fi

for package in $@
do 
    dnf list installed $package &>>$LOG_FILE
    if[$? -ne 0]; then
        dnf install $package -y &>>$LOG_FILE
        validate $? $package
    else
        echo "Already $package exist.. $G Skipping $N" | tee -a $LOG_FILE
      
    fi 

done 


