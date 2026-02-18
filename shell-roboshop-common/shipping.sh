#!/bin/bash

source ./common.sh
app_name=shipping
check_root
app_setup
java_setup
systemd_setup



dnf install mysql -y  &>>$LOG_FILE
validate $? "Install MYSQL"
mysql -h mysql.cloudskills.fun -uroot -pRoboShop@1 -e 'use cities'  &>>$LOG_FILE
if [ $? -ne 0 ]; then   # If already exist then it is 0 or if non-zero then schemas are not created 
mysql -h mysql.cloudskills.fun -uroot -pRoboShop@1 < /app/db/schema.sql
mysql -h mysql.cloudskills.fun -uroot -pRoboShop@1 < /app/db/app-user.sql 
mysql -h mysql.cloudskills.fun -uroot -pRoboShop@1 < /app/db/master-data.sql
else
  echo "Shipping data is already loaded $Y SKIPPING $N"
fi


app_restart