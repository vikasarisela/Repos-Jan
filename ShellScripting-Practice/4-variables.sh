#! /bin/bash

DATE = $(date) - executes command
Echo "$DATE"


start_time=$(date +%s)
sleep 10 &
end_time=$(date +%s)
total_time=$((end_time-start_time))
echo "$total_time in seconds"