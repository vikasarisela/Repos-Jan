#!/bin/bash

count=5

echo="start count down"

while [ $count -gt 0 ]
do 
    echo "Time Left: $count"
    sleep 1 
    count=$(($count -1))
done

# while IFS= read -r filepath 
# do
#     # Process each line here
#     echo "Deleting the file: $filepath"
# done <<< 15-script-2.sh