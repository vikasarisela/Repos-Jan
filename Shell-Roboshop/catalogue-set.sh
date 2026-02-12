#bin/bash
set -euo pipefail
trap 'echo "There is an error in $LINENO, Command is: $BASH_COMMAND"' ERR

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

# log folder creating in 
LOG_FOLDER=/var/log/shellscripting-logs
SCRIPT_NAME=$( echo $0 | cut -d "." -f1)   #$0 you will get script name 
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"
SCRIPT_DIR=$PWD

mkdir -p $LOG_FOLDER
echo "script started executed at $(date)"  | tee -a $LOG_FILE


if [ $USERID -ne 0 ]; then 
  echo "Error: Please run the script with root priviliges"
  exit 1
fi



#NodeJS Installation#
dnf module disable nodejs -y &>>$LOG_FILE
dnf module enable nodejs:20 -y  &>>$LOG_FILE
dnf install nodejs -y  &>>$LOG_FILE


id roboshop &>>$LOG_FILE
if [ $? -ne 0 ]; then
  useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>>$LOG_FILE
else 
   echo -e "User Already Existing .. Skipping.."
fi

mkdir -p /app  

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip   &>>$LOG_FILE
cd /app  &>>$LOG_FILE

rm -rf /app/*
unzip /tmp/catalogue.zip &>>$LOG_FILE

cd /app  &>>$LOG_FILE
npm install &>>$LOG_FILE

cp $SCRIPT_DIR/catalogue.service /etc/systemd/system/catalogue.service &>>$LOG_FILE
systemctl daemon-reload &>>$LOG_FILE

systemctl enable catalogue  &>>$LOG_FILE
systemctl start catalogue &>>$LOG_FILE
cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
dnf install mongodb-mongosh -y &>>$LOG_FILE

INDEX=$(mongosh mongodb.cloudskills.fun --quiet --eval "db.getMongo().getDBNames().includes('catalogue')")
if [ $INDEX -le 0 ]; then 
    mongosh --host mongodb.cloudskills.fun </app/db/master-data.js  &>>$LOG_FILE
    else 
    echo -e "Catalogue Products already loaded ... $Y SKIPPING.. $N"
fi
systemctl restart catalogue  &>>$LOG_FILE

# Tocheck already database exist
# mongosh mongodb.cloudskills.fun --quiet --eval "db.getMongo().getDBNames().includes('catalogue')"


# something
