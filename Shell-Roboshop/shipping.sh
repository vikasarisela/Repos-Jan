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

dnf install maven -y &>>$LOG_FILE
validate $? "Installing Maven"

id roboshop &>>$LOG_FILE
if [ $? -ne 0 ]; then
  useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>>$LOG_FILE
  validate $? "Creating System User"
else 
   echo -e "User Already Existing .. Skipping.."
fi

validate $? "Creating system user"
mkdir /app 

curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip  &>>$LOG_FILE
validate $? "Downloading Shipping code"
cd /app 
rm -rf /app/*
unzip /tmp/shipping.zip
validate $? "Unzipping Shipping code"

cd /app 
mvn clean package   &>>$LOG_FILE
validate $? "Installing Dependencies"
mv target/shipping-1.0.jar shipping.jar   &>>$LOG_FILE

cp $SCRIPT_DIR/shipping.service /etc/systemd/system/shipping.service  &>>$LOG_FILE
validate $? "Copying shipping service to systemd "
systemctl daemon-reload   &>>$LOG_FILE
validate $? "Daemon Reload"
systemctl enable shipping  &>>$LOG_FILE
validate $? "Enable Shipping"
systemctl start shipping
validate $? "Starting Shipping Service"

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

systemctl restart shipping  &>>$LOG_FILE
validate $? "Restarting Shipping Service "