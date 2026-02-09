#!/bin/bash
USERID=$(id -u)
if [USERID -ne 0]; then 
  echo "Error: Please run the script with root priviliges"
  exit 1
fi

dnf install mysql -y 

if [$? ne 0]; then 
  echo "Error: Installing MYSQL is failure"
  else
  echo "MYSQL installation is successfull.."
   

 
# USERID=$(id -u)

# if [ $USERID -ne 0 ]; then 
#     echo "Error: Please run the script with root privileges"
#     exit 1
# else
#     dnf install mysql -y 

#     if [ $? -ne 0 ]; then 
#         echo "Error: Installing MYSQL failed"
#         exit 1
#     else
#         echo "MYSQL installation was successful."
#     fi
# fi
