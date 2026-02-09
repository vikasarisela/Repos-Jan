#!/bin/bash

echo "enter the number"
read NUMBER

if [$((NUMBER % 2)) -eq 0] then
echo "given number  $NUMBER is Even"
else 
echo "Odd number"
fi  