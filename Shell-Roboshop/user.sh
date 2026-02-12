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

dnf module disable nodejs -y
validate $? "Disable Nodejs"
dnf module enable nodejs:20 -y
validate $? "Enable Nodejs"

dnf install nodejs -y
validate $? "Install Nodejs"

useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
validate $? "Creating System User "

mkdir /app 

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip 
validate $? ""
cd /app 
unzip /tmp/user.zip
validate $? "Unzipping Code "

cd /app 
npm install 
validate $? "Installing Dependencies"

cp $SCRIPT_DIR/user.service  /etc/systemd/system/user.service
validate $? "copying user service"

systemctl daemon-reload
validate $? "Daemon Reload"

systemctl enable user 
validate $? "Enable User Service.."
systemctl start user
validate $? "Start User Service..."