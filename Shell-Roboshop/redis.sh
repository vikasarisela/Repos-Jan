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


dnf module disable redis -y   &>>$LOG_FILE
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