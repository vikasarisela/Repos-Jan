#bin/bash

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

#NodeJS Installation#
dnf module disable nodejs -y &>>$LOG_FILE
validate $? "Nodejs Module Disabled"
dnf module enable nodejs:20 -y  &>>$LOG_FILE
validate $? "Nodejs Module Enabled"
dnf install nodejs -y  &>>$LOG_FILE
validate $? "Install Nodejs Module"


id roboshop &>>$LOG_FILE
if [ $? -ne 0 ]; then
  useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>>$LOG_FILE
  validate $? "Creating System User"
else 
   echo -e "User Already Existing .. Skipping.."
fi

mkdir -p /app  
validate $? "Creating App Directory"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip   &>>$LOG_FILE
validate $? "Downloading Catalogue Application"
cd /app  &>>$LOG_FILE
validate $? "Changing to app directory"

rm -rf /app/*
validate $? "Removing Existing Code"
unzip /tmp/catalogue.zip &>>$LOG_FILE
validate $? "Unzipping Catalogue Applcation"

cd /app  &>>$LOG_FILE
validate $? "changing directory to app"  
npm install &>>$LOG_FILE
validate $? "Install Dependencies.."

cp $SCRIPT_DIR/catalogue.service /etc/systemd/system/catalogue.service &>>$LOG_FILE
validate $? "Copying catalogue Service"
systemctl daemon-reload &>>$LOG_FILE
validate $? "Reloading Daemon"

systemctl enable catalogue  &>>$LOG_FILE
validate $? "Enable Catalogue Service"
systemctl start catalogue &>>$LOG_FILE
validate $? "Starging Catalogue Service"
cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
validate $? "Copying MongoRepo to yum repos.."
dnf install mongodb-mongosh -y &>>$LOG_FILE
validate $? "Installing Mongodb client.."
mongosh --host mongodb.cloudskills.fun </app/db/master-data.js  &>>$LOG_FILE
validate $? "Connecting to Mongodb and loading catalogue products"
systemctl restart catalogue  &>>$LOG_FILE
validate $? "Restarted Catalogue Service.."

# Tocheck already database exist
# mongosh mongodb.cloudskills.fun --quiet --eval "db.getMongo().getDBNames().includes('catalogue')"
