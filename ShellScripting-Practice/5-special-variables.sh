#!/bin/bash

echo "all variables passed to the script: $@"
echo "all variables passed to the script: $*"
echo "script name: $0"
echo "current directory : $PWD"
echo "who is running the script : $USER"
echo "current user home directory : $HOME"
echo "PID of the script : $$"
echo "PID of the last command in the background : $!"