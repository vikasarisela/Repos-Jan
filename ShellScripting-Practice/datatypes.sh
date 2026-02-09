#!/bin/bash

number1=100
number2=200
name=vikas
sum=$(($number1+$number2+$name))
echo "total is ${sum}"

#prints only  300  because name can't be added  name will be consider as 0  

#size = 3 index = 2
Leaders=("trump" "trudo" "modi")
echo "all leaders ${Leaders[@]}"
echo "all leaders ${Leaders[1]}"
echo "all leaders ${Leaders[2]}"

Date=$(date +%s)
echo "timestamp $Date"