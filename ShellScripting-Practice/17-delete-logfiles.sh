#!/bin/bash

SOURCE_DIR=/home/ec2-user/app-logs

#checks the directory exists or not
 if [ ! -d $SOURCE_DIR ]; then
    echo -e "ERROR:: $SOURCE_DIR does not exist"
    exit 1
 fi

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -type f -mtime +14)

while IFS= read -r filepath
do
    echo "Deleting the file: $filepath"
    rm -rf $filepath
    echo "Deleted the file: $filepath"
done <<< $FILES_TO_DELETE