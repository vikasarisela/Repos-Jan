#!/bin/bash

source ./common.sh
app_name=redis
check_root

dnf module disable $app_name -y   &>>$LOG_FILE
validate $? "Disabling redis module"  
dnf module enable redis:7 -y   &>>$LOG_FILE
validate $? "Enabling redis module" 
dnf install redis -y   &>>$LOG_FILE
validate $? "Installing redis module"

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf  &>>$LOG_FILE
validate $? "Port opened for remote connections"


systemctl enable redis &>>$LOG_FILE
validate $? "Enabling redis "
systemctl start redis  &>>$LOG_FILE
validate $? "Starting Redis"