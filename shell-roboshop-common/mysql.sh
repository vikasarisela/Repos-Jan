
#!/bin/bash

source ./common.sh

check_root



dnf install mysql-server -y   &>>$LOG_FILE
validate $? "Installing MySQL Server"  
systemctl enable mysqld  &>>$LOG_FILE
validate $? "Enabling MYSQL Server"  
systemctl start mysqld   &>>$LOG_FILE
validate $? "Starting Mysqld"  

mysql_secure_installation --set-root-pass RoboShop@1  &>>$LOG_FILE
validate $? "Set Root passwod "  