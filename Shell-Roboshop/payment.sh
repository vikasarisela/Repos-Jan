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


dnf install python3 gcc python3-devel -y
validate $? "Installing Python" 
useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
validate $? "Adding System User" 
mkdir /app 

curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip 
validate $? "Downloading code.." 
cd /app 
unzip /tmp/payment.zip
validate $? "Unzipping " 

cd /app 
pip3 install -r requirements.txt
validate $? "Installing Dependencies" 

cp $SCRIPT_DIR/payment.service /etc/systemd/system/payment.service
validate $? "Copying payement service" 
systemctl daemon-reload
validate $? "Daemon Reload" 
systemctl enable payment 
validate $? "Enable Payment" 
systemctl start payment
validate $? "Start Payment Service" 