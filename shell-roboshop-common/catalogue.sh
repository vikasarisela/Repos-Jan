#!/bin/bash

source ./common.sh
app_name=catalogue

check_root
app_setup
nodejs_setup
systemd_setup


cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
validate $? "Copying MongoRepo to yum repos.."
dnf install mongodb-mongosh -y &>>$LOG_FILE
validate $? "Installing Mongodb client.."

INDEX=$(mongosh mongodb.cloudskills.fun --quiet --eval "db.getMongo().getDBNames().includes('catalogue')")
if [ $INDEX -le 0 ]; then 
    mongosh --host mongodb.cloudskills.fun </app/db/master-data.js  &>>$LOG_FILE
    validate $? "Load $app_name products"
else 
    echo -e "$app_name products already loaded ... $Y SKIPPING.. $N"
fi

app_restart
