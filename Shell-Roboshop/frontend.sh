#bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

# log folder creating in 
LOG_FOLDER=/var/log/shellscripting-logs
SCRIPT_NAME=$( echo $0 | cut -d "." -f1)   #$0 you will get script name 
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOG_FOLDER
echo "script started executed at $(date)"  | tee -a $LOG_FILE

USERID=$(id -u)
if [ $USERID -ne 0 ]; then 
  echo "Error: Please run the script with root priviliges"
  exit 1
fi


#Calling Function recieve inputs through args 
validate(){
if [ $1 -ne 0 ]; then    # 0 is success and 1-127 is failure 
     echo -e "$2 .... $R FAILURE $N" | tee -a $LOG_FILE
     exit 1
  else
    echo -e "$2 .... $G SUCCESSFUL $N.." | tee -a $LOG_FILE    
  fi
}

dnf module disable nginx -y &>>$LOG_FILE
validate $? "Disabling Nginx"
dnf module enable nginx:1.24 -y  &>>$LOG_FILE
validate $? "Enabling Nginx 1.24"
dnf install nginx -y   &>>$LOG_FILE
validate $? "Installing Nginx"

systemctl enable nginx  &>>$LOG_FILE
validate $? "Enabling Nginx" 
systemctl start nginx   &>>$LOG_FILE
validate $? "Start Nginx"

rm -rf /usr/share/nginx/html/*   &>>$LOG_FILE
validate $? "Remove Default HTML"

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip  &>>$LOG_FILE
validate $? "Download Front End Code"

cd /usr/share/nginx/html  &>>$LOG_FILE
unzip /tmp/frontend.zip
validate $? "Unzipping .. front end"

rm -rf /etc/nginx/nginx.conf
cp $SCRIPT_DIR/nginx.conf /etc/nginx/nginx.conf
validate $? "Copying nginx service"

systemctl restart nginx   
validate $? "Resarting Nginx"