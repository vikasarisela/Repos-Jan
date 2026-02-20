# R="\e[31m"
# G="\e[32m"
# Y="\e[33m"
# N="\e[0m"

# # log folder creating in 
# LOG_FOLDER=/var/log/shellscripting-logs
# SCRIPT_NAME=$( echo $0 | cut -d "." -f1)   #$0 you will get script name 
# LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"

# mkdir -p $LOG_FOLDER
# echo "script started executed at $(date)"  | tee -a $LOG_FILE



# SOURCE_DIR=~/app-logs

# if [ ! -d $SOURCE_DIR ]; then # to check source directory exist or not , if there is it is true
#     echo -e "ERROR:: $SOURCE_DIR does not exist"
#     exit 1 
# fi  

# FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -type f  -mtime  +14)

# while IFS= read -r filepath 
# do
#     # Process each line here
#     echo "Deleting the file: $filepath"
#    # rm -rf $filepath
#     echo "Deleted the file: $filepath"
# done <<< $FILES_TO_DELETE

SOURCE_DIR=/home/ec2-user/app-logs

if [ ! -d $SOURCE_DIR ]; then
    echo -e "ERROR:: $SOURCE_DIR does not exist"
    exit 1
fi

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -type f -mtime +14)

while IFS= read -r filepath
do
    echo "Deleting the file: $filepath"
    # rm -rf $filepath
    echo "Deleted the file: $filepath"
done <<< $FILES_TO_DELETE

