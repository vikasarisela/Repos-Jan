#!/bin/bash

source ./common.sh

check_root



cp $SCRIPT_DIR/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo   &>>$LOG_FILE
validate $? "Copying Rabbitmq Repo to ym.repos"
dnf install rabbitmq-server -y  &>>$LOG_FILE
validate $? "Installing Rabbit-mq server"
systemctl enable rabbitmq-server  &>>$LOG_FILE
validate $? "Enabling Rabbit-mq server"
systemctl start rabbitmq-server  &>>$LOG_FILE
validate $? "Starting Rabbit-mq server"

rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
validate $? "Adding User Roboshop"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"   &>>$LOG_FILE
validate $? "Setting Permissions.."